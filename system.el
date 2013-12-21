;; ;; a bit of slime
;; ;; I don't like that it references something that I can't be sure
;; ;; Emacs has by default, but this is currently the best way to have
;; ;; SLIME work seamlessly.
;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; (setq inferior-lisp-program "/usr/local/bin/ccl") ; your Lisp system

;; ;; Change this to whatever you use. It's necessary on osx not to get
;; ;; errors with M-x dired
;; (setq insert-directory-program "/usr/local/bin/gls")

;; Comment this if you want to stick to ispell in place of aspell
;; (setq ispell-program-name "/usr/local/bin/aspell")
;; (setq ispell-extra-args '("--sug-mode=ultra"))

;; ;; Erlang initialization
;; ;; Set the variables to your taste and needs
;; (setq load-path (cons  "/usr/local/Cellar/erlang/R15B01/lib/erlang/lib/tools-2.6.7/emacs"
;;                        load-path))
;; (setq erlang-root-dir "/usr/local/Cellar/erlang/R15B01")
;; (setq exec-path (cons "/usr/local/Cellar/erlang/R15B01/bin" exec-path))
;; (require 'erlang-start)

;; Needed for my environment. What follows now should be customized to
;; your PATHS
(if (not (getenv "TERM_PROGRAM"))
    (setenv "PATH"
            (shell-command-to-string "source $HOME/.bash_profile && printf $PATH")))

;; (setq scala-interpreter "/usr/local/bin/scala")
;; (setq coffee-command "/usr/local/bin/coffee")

(setq lua-default-application "/usr/local/bin/lua")

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; customize this to your taste
(load-theme 'spolsky t)

;; powerline theme
(powerline-default-theme)
(setq powerline-color1 "#073642")
(setq powerline-color2 "#002b36")

(set-face-attribute 'mode-line nil
                    :foreground "#fdf6e3"
                    :background "#2aa198"
		    :inverse-video nil
                    :box nil)
(set-face-attribute 'mode-line-inactive nil
                    :box nil)

;; enable rainbow mode
;; (rainbow-mode 1)

;; bind meta key to command
;; (setq mac-option-modifier 'super)
;; (setq mac-command-modifier 'meta)
