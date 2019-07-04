(defun fira-code-mode--make-alist (list)
  "Generate prettify-symbols alist from LIST."
  (let ((idx -1))
    (mapcar
     (lambda (s)
       (setq idx (1+ idx))
       (let* ((code (+ #Xe100 idx))
              (width (string-width s))
              (prefix ())
              (suffix '(?\s (Br . Br)))
              (n 1))
         (while (< n width)
           (setq prefix (append prefix '(?\s (Br . Bl))))
           (setq n (1+ n)))
         (cons s (append prefix suffix (list (decode-char 'ucs code))))))
     list)))

(defconst fira-code-mode--ligatures
  '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\"
    "{-" "[]" "::" ":::" ":=" "!!" "!=" "!==" "-}"
    "--" "---" "-->" "->" "->>" "-<" "-<<" "-~"
    "#{" "#[" "##" "###" "####" "#(" "#?" "#_" "#_("
    ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*"
    "/**" "/=" "/==" "/>" "//" "///" "&&" "||" "||="
    "|=" "|>" "^=" "$>" "++" "+++" "+>" "=:=" "=="
    "===" "==>" "=>" "=>>" "<=" "=<<" "=/=" ">-" ">="
    ">=>" ">>" ">>-" ">>=" ">>>" "<*" "<*>" "<|" "<|>"
    "<$" "<$>" "<!--" "<-" "<--" "<->" "<+" "<+>" "<="
    "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<" "<~"
    "<~~" "</" "</>" "~@" "~-" "~=" "~>" "~~" "~~>" "%%"
    "x" ":" "+" "+" "*"))

(defvar fira-code-mode--old-prettify-alist)

(defun fira-code-mode--enable ()
  "Enable Fira Code ligatures in current buffer."
  (setq-local fira-code-mode--old-prettify-alist prettify-symbols-alist)
  (setq-local prettify-symbols-alist (append (fira-code-mode--make-alist fira-code-mode--ligatures) fira-code-mode--old-prettify-alist))
  (prettify-symbols-mode t))

(defun fira-code-mode--disable ()
  "Disable Fira Code ligatures in current buffer."
  (setq-local prettify-symbols-alist fira-code-mode--old-prettify-alist)
  (prettify-symbols-mode -1))

(define-minor-mode fira-code-mode
  "Fira Code ligatures minor mode"
  :lighter " Fira Code"
  (setq-local prettify-symbols-unprettify-at-point 'right-edge)
  (if fira-code-mode
      (fira-code-mode--enable)
    (fira-code-mode--disable)))

(defun fira-code-mode--setup ()
  "Setup Fira Code Symbols"
  (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol"))

(provide 'fira-code-mode)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)



(setq ingibit-startup-message t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode 1)
(defalias 'list-buffers 'ibuffer-other-window)
(setq make-backup-files nil) ;stop creating backup~ files
(setq auto-save-default nil) ;stop creating #autosave# files
(setq column-number-mode t)
;; C-c C-d will duplicate current line
(global-set-key "\C-c\C-d" "\C-a\C- \C-n\M-w\C-y")

(use-package try
  :ensure )

(use-package ace-window
  :ensure t
  :config
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
    '(aw-leading-char-face
      ((t (:inherit ace-jump-face-foreground :height 3.0)))))
    ))

(use-package move-text
  :ensure t
  :bind (("M-p" . move-text-up)
         ("M-n" . move-text-down)))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package doom-themes
  :ensure t
  :init
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; ..:: THEMES ::..
  ;;(load-theme 'doom-nova t)
  ;;(load-theme 'doom-one t)
  ;;(load-theme 'doom-one-light t)
  ;;(load-theme 'doom-vibrant t)
  ;;(load-theme 'doom-city-lights t)
  ;;(load-theme 'doom-dracula t)
  ;;(load-theme 'doom-Iosvkem t)
  ;;(load-theme 'doom-molokai t)
  ;;(load-theme 'doom-nord t)
  ;;(load-theme 'doom-nord-light t)
  ;;(load-theme 'doom-opera t)
  ;;(load-theme 'doom-opera-light t)
  ;;(load-theme 'doom-nova t)
  (load-theme 'doom-peacock t)
  ;;(load-theme 'doom-solarized-light t)
  ;;(load-theme 'doom-sourcerer t)
  ;;(load-theme 'doom-spacegrey t)
  ;;(load-theme 'doom-tomorrow-night t)
  ;;(load-theme 'doom-mono-dark t)
  ;;(load-theme 'doom-mono-light t)
  ;;(load-theme 'doom-tron t)
  ;;===============================
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

;;(use-package spaceline
;;  :ensure t
;;  :config
;;  (spaceline-emacs-theme))
;;
;;(use-package spaceline-all-the-icons
;;  :ensure t
;;  :after spackeline
;;  :config
;;  (spaceline-all-the-icons-theme))
;;

 (use-package doom-modeline
   :ensure t
   :hook (after-init . doom-modeline-mode)
   :config
   (setq doom-modeline-buffer-file-name-style 'relative-to-project)
   (setq doom-modeline-icon t)
   (setq doom-modeline-major-mode-icon t)
   (setq doom-modeline-major-mode-color-icon t)
   (setq doom-modeline-buffer-state-icon t)
   (setq doom-modeline-buffer-modification-icon t)
   (setq doom-modeline-minor-modes nil))

(use-package all-the-icons
  :ensure t)

(use-package neotree
  :ensure t
  :init
  (global-set-key [f8] 'neotree-toggle))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package smartparens 
  :ensure t
  :config
  (use-package smartparens-config)
  (smartparens-global-mode t)
  (show-smartparens-global-mode t)
  :bind
  (
   ("C-<down>" . sp-down-sexp)
   ("C-<up>" . sp-up-sexp)
   ("M-<down>" . sp-backward-down-sexp)
   ("M-<up>" . sp-backward-up-sexp)
   ("C-M-a" . sp-beginning-of-sexp)
   ("C-M-e" . sp-end-of-sexp)

   ("C-M-f" . sp-forward-sexp)
   ("C-M-b" . sp-backward-sexp)
   ("C-M-n" . sp-next-sexp)
   ("C-M-p" . sp-previous-sexp)

   ("C-M-k" . sp-kill-sexp)
   ("C-k" . sp-kill-hybrid-sexp)
   ("M-k" . sp-backward-kill-sexp)
   ("C-M-w" . sp-copy-sexp)

   ("C-M-d" . delete-sexp)
   ("M-[" . sp-backward-unwrap-sexp)
   ("M-]" . sp-unwrap-sexp)

   ("C-x C-t" . sp-transpose-hybrid-sexp)

   ("C-c ("  . wrap-with-parens)
   ("C-c ["  . wrap-with-brackets)
   ("C-c {"  . wrap-with-braces)
   ("C-c '"  . wrap-with-single-quotes)
   ("C-c \"" . wrap-with-double-quotes)
   ("C-c _"  . wrap-with-underscores)
   ("C-c `"  . wrap-with-back-quotes)
   )
  )

(use-package counsel
  :ensure t
  )

(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffer t)
  (setq ivy-display-style 'fancy))

;;http://oremacs.com/swiper/
(use-package swiper
  :ensure try
  :bind (("C-s" . swiper)
	 ;;("C-c C-r" . ivy-resume)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffer t)
    (setq ivy-display-style 'fancy)
    ;;(define-key read-expression-map (kbd C-r) 'counsel-expression-history)
    ))

;;https://github.com/abo-abo/avy
(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))

;;use only spaces in indentation
(progn
  (setq-default indent-tabs-mode nil))

(setq c-default-style "k&r"
      c-basic-offset 4)

(use-package srefactor
  :ensure t
  :config
  (semantic-mode 1)
  (define-key c-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
  (define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point))

(use-package cmake-mode
  :ensure t)

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-ide-delay 0)
  (setq company-minimum-prefix-length 1)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

(use-package lsp-mode
  :ensure t
  :commands lsp
  :config
  (require 'lsp-clients)
  (add-hook 'prog-mode-hook 'lsp)
  (setq lsp-prefer-flymake nil)
  (add-hook 'lsp-after-open-hook 'lsp-enable-imenu)
  (setq-default flycheck-disabled-checkers '(c/c++-cppcheck c/c++-gcc))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "pyls")
                    :major-modes '(python-mode)
                    :server-id 'pyls)))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-ignore-duplicate t)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (add-hook 'c++-mode-hook 'flycheck-mode)
  (add-hook 'python-mode-hook 'flycheck-mode)
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))

(use-package company-lsp
  :ensure t
  :commands company-lsp
  :config
  (push 'company-lsp company-backends))

(use-package ccls
  :ensure t
  :hook
  ((c-mode c++-mode objc-mode) .
   (lambda () (require 'ccls) (lsp)))
  :config
  (if (eq system-type 'gnu/linux)
      (setq ccls-executable "~/Projekty/ccls/Release/ccls"))
  (if (eq system-type 'windows-nt)
      (setq ccls-executable "c:/Program Files (x86)/ccls/bin/ccls.exe")))

(use-package clang-format
  :ensure t
  :config
  (global-set-key (kbd "C-c u") 'clang-format-buffer)
  (global-set-key (kbd "C-c i") 'clang-format-region))

(setq python-indent-offset 4)

(use-package virtualenvwrapper
  :ensure t
  :config
  (venv-initialize-eshell)
  (setq venv-location "~/Projekty/python/environments/"))

;; NB: only required if you prefer flake8 instead of the default
;; send pyls config via lsp-after-initialize-hook -- harmless for
;; other servers due to pyls key, but would prefer only sending this
;; when pyls gets initialised (:initialize function in
;; lsp-define-stdio-client is invoked too early (before server
;; start)) -- cpbotha
(defun lsp-set-cfg ()
  (let ((lsp-cfg `(:pyls (:configurationSources ("flake8")))))
    ;; TODO: check lsp--cur-workspace here to decide per server / project
    (lsp--set-configuration lsp-cfg)))

(add-hook 'lsp-after-initialize-hook 'lsp-set-cfg)

  ;; (use-package elpy
  ;;   :ensure t
  ;;   :config
  ;;   (elpy-enable)
  ;;   (setq python-shell-interpreter "jupyter"
  ;;         python-shell-interpreter-args "console --simple-prompt"
  ;;         python-shell-prompt-detect-failure-warning nil)
  ;;   (add-to-list 'python-shell-completion-native-disabled-interpreters "jupyter"))

(use-package py-autopep8
  :ensure t
  :config
  (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save))

(use-package yasnippet-snippets
  :ensure t)

(use-package yasnippet
  :ensure t
  :config
  (yas-reload-all)
  (add-hook 'c-mode-hook 'yas-minor-mode)
  (add-hook 'c++-mode-hook 'yas-minor-mode)
  (add-hook 'objc-mode-hook 'yas-minor-mode)
  (add-hook 'java-mode-hook 'yas-minor-mode)
  (add-hook 'python-mode-hook 'yas-minor-mode)
  (add-hook 'org-mode-hook 'yas-minor-mode))