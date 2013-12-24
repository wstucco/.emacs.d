;; loading interface defaults ASAP
(load (concat user-emacs-directory "interface.el"))

;; loading package.el ASAP to avoid errors
(require 'package)

(add-to-list 'package-archives
    '("marmalade" . "http://marmalade-repo.org/packages/") )
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; Initialize el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (goto-char (point-max))
       (eval-print-last-sexp)))))

(setq my-packages
  (append
   '(el-get smex flycheck paredit yasnippet inf-ruby rvm ruby-compilation
    magit haml-mode flymake-haml bundler sass-mode coffee-mode php-mode-improved powerline
    smarty-mode idle-highlight-mode apache-mode lua-mode yaml-mode web-mode
    color-theme-solarized rainbow-mode exec-path-from-shell
    projectile wrap-region auto-complete go-mode go-autocomplete)
    (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-packages)

;;
;; post el-get configuration
;;

;; set PATH environment for OS X
(require 'exec-path-from-shell)
(if (featurep 'exec-path-from-shell)
    (when (memq window-system '(mac ns))
      (exec-path-from-shell-initialize)))

;; function definitions
(load (concat user-emacs-directory "functions.el"))

;; load other emacs defaults
(load (concat user-emacs-directory "defaults.el"))

;; language hooks
(load (concat user-emacs-directory "languages.el"))

;; load system-tailored defaults you should probably edit this
(load (concat user-emacs-directory "system.el"))

;; el-get cannot currently recompile mu4e, load it manually
;; (load (concat user-emacs-directory "mu4e.el")) ; mu4e config

;; emacs server goodness
(server-start)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(backup-inhibited t t)
 '(cursor-type (quote bar) t)
 '(custom-safe-themes (quote ("e26780280b5248eb9b2d02a237d9941956fc94972443b0f7aeec12b5c15db9f3" "68769179097d800e415631967544f8b2001dae07972939446e21438b1010748c" default)))
 '(echo-keystrokes 0.01)
 '(fill-column 78)
 '(flymake-cursor-error-display-delay 0)
 '(frame-title-format (quote ("%f - " user-real-login-name "@" system-name)) t)
 '(ido-auto-merge-work-directories-length nil)
 '(ido-create-new-buffer (quote always))
 '(ido-enable-flex-matching t)
 '(ido-enable-prefix nil)
 '(ido-everywhere t)
 '(ido-ignore-extensions t)
 '(ido-max-prospects 8)
 '(ido-use-filename-at-point (quote guess))
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(linum-format "  %d  ")
 '(package-archives (quote (("gnu" . "http://elpa.gnu.org/packages/") ("marmalade" . "http://marmalade-repo.org/packages/"))))
 '(puppet-indent-level tab-width)
 '(recentf-max-saved-items 75)
 '(require-final-newline t)
 '(ruby-indent-level tab-width)
 '(show-paren-delay 0)
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
