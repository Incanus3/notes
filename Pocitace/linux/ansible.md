# Ansible

## Task flow

### Use `with_items` to loop over several items

```yaml
- name: "Start Apache, MySQL, and PHP."
  service: "name={{ item }} state=started enabled=yes"
  with_items:
    - apache2
    - mysql
```

### Run task depending on another task's change

```yaml
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
```

### Run task depending on another task's output

```yaml
- name: Check list of running Node.js apps.
  command: forever list
  register: forever_list
  changed_when: false

- name: Start example Node.js app.
  command: "forever start {{ node_apps_location }}/app/app.js"
  when: "forever_list.stdout.find(node_apps_location + '/app/app.js') == -1"
```

### Use handlers to run task if some tasks changed the server state

```yaml
handlers:
  - name: restart apache
    service: name=apache2 state=restarted

tasks:
  - name: Enable Apache rewrite module (required for Drupal).
    apache2_module: name=rewrite state=present
    notify: restart apache
```

- Handlers can take a list.
- Handlers can notify other handlers.
- Handlers run once at the end of play, if all tasks succeeded.
- They can be forced to run sooner using a `meta: flush_handlers` task.
- Use `--force-handlers` to run handlers after failed plays too.

## Files and templates

### Create file from template

```yaml
- name: Add Apache virtualhost for Drupal 8 development.
  template:
    src: "templates/drupal.test.conf.j2"
    dest: "/etc/apache2/sites-available/{{ domain }}.test.conf"
```

### Create link

```yaml
- file:
    src: "/etc/apache2/sites-available/{{ domain }}.test.conf"
    dest: "/etc/apache2/sites-enabled/{{ domain }}.test.conf"
    state: link
```

## Environment variables

### Set environment variables for one task

```yaml
- name: Download a file, using example-proxy as a proxy.
  get_url: url=http://www.example.com/file.tar.gz dest=~/Downloads/
  environment:
    http_proxy: http://example-proxy:80/
```

### Set environment variables as a dict and use in task

```yaml
vars:
  proxy_vars:
    http_proxy: http://example-proxy:80/
    https_proxy: https://example-proxy:443/

tasks:
  - name: Download a file, using example-proxy as a proxy.
    get_url: url=http://www.example.com/file.tar.gz dest=~/Downloads/
    environment: proxy_vars
```

### Set environment variables in `/etc/environment`

```yaml
vars:
  proxy_state: present

tasks:
  - name: Configure the proxy.
    lineinfile:
      dest: /etc/environment
      regexp: "{{ item.regexp }}"
      line: "{{ item.line }}"
      state: "{{ proxy_state }}"
    with_items:
      - regexp: "^http_proxy="
        line: "http_proxy=http://example-proxy:80/"
      - regexp: "^https_proxy="
        line: "https_proxy=https://example-proxy:443/"
      - regexp: "^ftp_proxy="
        line: "ftp_proxy=http://example-proxy:80/"
```
