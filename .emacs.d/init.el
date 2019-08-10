(require 'package)
(savehist-mode 1)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(setq inhibit-startup-message t)
(set-window-buffer nil (current-buffer))
;; (global-linum-mode t)
(package-initialize)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode t)
  (modify-syntax-entry ?_ "w")
  (setq evil-want-C-u-scroll t)
  (use-package evil-commentary
    :ensure t
    :config
    (evil-commentary-mode))
  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader ",")
    (evil-leader/set-key
      "m" 'helm-M-x))
  (use-package evil-collection
    :ensure t
    :config
    (evil-collection-init 'outline)))

(use-package helm
  :ensure t
  :config
  (helm-mode 1)
  (global-set-key (kbd "M-x") 'helm-M-x))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode))

(use-package neotree
  :ensure t
  :config
  (evil-leader/set-key
    "t" 'neotree-toggle)
  (setq neo-smart-open t))

;;
;; Plugins
;;

;; Highlight matching brackets.
(show-paren-mode 1)

;; remember cursor position, for emacs 25.1 or later
(save-place-mode 1)

;; ido-mode has a *much* better buffer selection (and file opening) :).
(ido-mode)

;; fix terminal in tmux and in kitty
(add-to-list 'term-file-aliases
     '("tmux-256color" . "xterm-256color"))
(add-to-list 'term-file-aliases
     '("tmux" . "xterm-256color"))
(add-to-list 'term-file-aliases
     '("xterm-kitty" . "xterm-256color"))
(add-to-list 'term-file-aliases
     '("alacritty" . "xterm-256color"))

(global-display-line-numbers-mode)
(auto-save-visited-mode)

(defalias 'yes-or-no-p 'y-or-n-p)

;; Do not clutter filesystem with backup files...
;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Highlight useful keywords
(add-hook 'prog-mode-hook
           (lambda ()
            (font-lock-add-keywords nil
             '(("\\<\\(FIXME\\|TODO\\|BUG\\|XXX\\):"
                font-lock-warning-face t)))))

;;
;; keybindings
;;

;;
;; whitespace settings
;;

(setq whitespace-line-column 80)
(setq whitespace-style '(face lines-tail trailing))

;; only enable whitespace settings in programming modes
(add-hook 'prog-mode-hook 'whitespace-mode)

;;
;; Programming Configuration
;;

;; c
(setq c-default-style "linux")

;; go
(set 'gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

;; python
(setq python-shell-interpreter "python3")

;; (eval-after-load "company"
;;   '(add-to-list 'company-backends 'company-anaconda))
;; (add-hook 'python-mode-hook 'anaconda-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil-collection evil-leader evil-commentary use-package go-mode evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
