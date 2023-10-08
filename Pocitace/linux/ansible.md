== use with_items to loop over several items ==

- name: "Start Apache, MySQL, and PHP."
  service: "name={{ item }} state=started enabled=yes"
  with_items:
    - apache2
    - mysql

== run task depending on another task's change ==

- name: Check out Drupal Core to the Apache docroot.
  git:
    repo: https://git.drupal.org/project/drupal.git
    version: "{{ drupal_core_version }}"
    dest: "{{ drupal_core_path }}"
  register: git_checkout
- name: Ensure Drupal codebase is owned by www-data.
  file:
    path: "{{ drupal_core_path }}"
    owner: www-data
    group: www-data
    recurse: true
  when: git_checkout.changed | bool

== run task depending on another task's output ==

- name: Check list of running Node.js apps.
  command:  forever list
  register: forever_list
  changed_when: false
- name: Start example Node.js app.
  command: "forever start {{ node_apps_location }}/app/app.js"
  when:    "forever_list.stdout.find(node_apps_location + '/app/app.js') == -1"

== use handers to run task if some tasks changed the server state ==

handlers:
- name: restart apache
  service: name=apache2 state=restarted

tasks:
- name: Enable Apache rewrite module (required for Drupal).
  apache2_module: name=rewrite state=present
  notify: restart apache

# can take list
# handlers can notify other handlers
# handlers run once at the end of play, if all tasks succeeded
# can be forced to run sooner using "meta: flush_handlers" task
# use --force-handlers to run handlers after failed plays too

== create file from template ==

- name: Add Apache virtualhost for Drupal 8 development.
  template:
    src: "templates/drupal.test.conf.j2"
    dest: "/etc/apache2/sites-available/{{ domain }}.test.conf"

== create link ==

- file:
    src: "/etc/apache2/sites-available/{{ domain }}.test.conf"
    dest: "/etc/apache2/sites-enabled/{{ domain }}.test.conf"
    state: link

== environment variables ==

# set for one task
- name: Download a file, using example-proxy as a proxy.
  get_url: url=http://www.example.com/file.tar.gz dest=~/Downloads/
  environment:
    http_proxy: http://example-proxy:80/

# set var as dict and us in task
vars:
  proxy_vars:
    http_proxy: http://example-proxy:80/
    https_proxy: https://example-proxy:443/
tasks:
- name: Download a file, using example-proxy as a proxy.
  get_url: url=http://www.example.com/file.tar.gz dest=~/Downloads/
  environment: proxy_vars

# or set in /etc/environment
vars:
  proxy_state: present

tasks:
  - name: Configure the proxy.
    lineinfile:
      dest: /etc/environment
      regexp: "{{ item.regexp }}"
      line:   "{{ item.line }}"
      state:  "{{ proxy_state }}"
    with_items:
      - regexp: "^http_proxy="
        line: "http_proxy=http://example-proxy:80/"
      - regexp: "^https_proxy="
        line: "https_proxy=https://example-proxy:443/"
      - regexp: "^ftp_proxy="
        line: "ftp_proxy=http://example-proxy:80/"
