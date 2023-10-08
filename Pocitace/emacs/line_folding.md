Content-Type: text/x-zim-wiki
Wiki-Format: zim 0.4
Creation-Date: 2013-11-02T09:41:06+01:00

====== line folding ======
Created Saturday 02 November 2013


http://www.emacswiki.org/cgi-bin/wiki/OutlineMode - code folding for emacs
;;; enables outlining for ruby
;;; You may also want to bind hide-body, hide-subtree, show-substree,
;;; show-all, show-children, ... to some keys easy folding and unfolding
(add-hook 'ruby-mode-hook
              '(lambda ()
                 (outline-minor-mode)
                 (setq outline-regexp " *\\(def \\|class\\|module\\)")))

    C-c @ C-a show all
    C-c @ C-t show only the headings
    C-c @ C-s show subtree at cursor location
    C-c @ C-d hide subtree at cursor location
