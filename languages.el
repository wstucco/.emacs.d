`;; paredit for lisp dialects
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
;; paredit for non lisps
(add-hook 'ruby-mode-hook 'intinig-paredit-nonlisp)
(add-hook 'html-mode-hook 'intinig-paredit-nonlisp)

;; highlight current line
(add-hook 'prog-mode-hook 'intinig-turn-on-hl-line-mode)

;; highlight words
(add-hook 'prog-mode-hook 'idle-highlight-mode)

;; ruby compilation in ruby mode
(eval-after-load 'ruby-mode
  '(progn
     (define-key ruby-mode-map (kbd "C-l") 'intinig-insert-equals-l)
     (define-key ruby-mode-map (kbd "C-x t") 'ruby-compilation-this-buffer)
     (define-key ruby-mode-map (kbd "C-x C-t") 'ruby-compilation-this-test)))

;; sass compilation in sass mode
(eval-after-load 'sass-mode
  '(progn
     (define-key sass-mode-map (kbd "C-x t") 'sass-compile-this-buffer)
     (define-key sass-mode-map (kbd "C-x C-t") 'sass-compile-region)))

;; no deep indentation for ruby
(setq ruby-deep-indent-paren nil)

;; Rake files are ruby, too, as are gemspecs, rackup files, etc.
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.thor$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Thorfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))

;; We never want to edit Rubinius bytecode or MacRuby binaries
(add-to-list 'completion-ignored-extensions ".rbc")
(add-to-list 'completion-ignored-extensions ".rbo")

;; Web-mode goodies
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; tab-widths
(setq coffee-tab-width 2)

;; enable flycheck for all supported buffers
(require 'flycheck )
(add-hook 'after-init-hook #'global-flycheck-mode)

;; go mode

(setenv "GOPATH" (expand-file-name "~/projects/go"))
(setenv "GOROOT" "/usr/local/go")
(setenv "PATH" (concat (getenv "PATH") ":" (concat (getenv "GOROOT") "/bin") ":" (concat (getenv "GOPATH") "/bin")))
(setq exec-path (append exec-path (concat (getenv "GOPATH") "/bin")))

(require 'go-mode)

(eval-after-load "go-mode"
  '(progn
    (add-hook 'go-mode-hook 'on-go-mode)

    ;; enable autocomplete for go-mode
    (require 'go-autocomplete)
    (require 'auto-complete-config)

    ;; enable flycheck color mode
    ; (require 'flycheck-color-mode-line)
    ; (eval-after-load "flycheck"
    ;   '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
))

(defun on-go-mode ()
  ; format before saving
  (setq gofmt-command "goimports") ;; run goimports instead of gofmt
  (add-hook 'before-save-hook 'gofmt-before-save) ;

  (global-auto-complete-mode t)
  (setq tab-width 2 indent-tabs-mode nil)

  (flycheck-mode)
)

(defun go-run-tests-on-save ()
  "After saving a go file, run tests"
  (interactive)
  (when (equal major-mode 'go-mode)
    (if buffer-file-name
      (let
        ((patchbuf (get-buffer-create "*Go test Output*"))
        (errbuf (get-buffer-create "*Go test Errors*"))
        (coding-system-for-read 'utf-8)
        (coding-system-for-write 'utf-8))

        (with-current-buffer errbuf
          (setq buffer-read-only nil)
          (erase-buffer))
        (with-current-buffer patchbuf
          (toggle-read-only nil)
          (erase-buffer))

     ;   ; (if (zerop (call-process "go" nil patchbuf nil "test" "-v"))
      ;   ;   (message "tests executed banana")))

        (with-current-buffer patchbuf
          (call-process "go" nil patchbuf nil "test" "./...")
          (compilation-mode)
          (require 'ansi-color)
          (ansi-color-apply-on-region (point-min) (point-max)))
        ; (with-current-buffer patchbuf
        ;   (ansi-color-apply-on-region (point-min) (point-max)))
        (display-buffer patchbuf)
        (message "go tests executed")

      )
    )
  )
)
;;(add-hook 'after-save-hook 'go-run-tests-on-save)
