;; Global variables
;; https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/
(defvar modi/gc-cons-threshold--orig gc-cons-threshold)
(setq gc-cons-threshold (* 100 1024 1024)) ;100 MB before garbage collection

(when (window-system)
  (set-default-font "Hasklug Nerd Font 16"))

(setq user-full-name "Brennan Fee")
(setq user-mail-address "brennan@todaytechsoft.biz")

(setq-default major-mode 'text-mode)
(line-number-mode 1)
(column-number-mode)
(display-time-mode 1)

(setq inhibit-startup-message t)
(setq initial-scratch-message "")

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;;; Set up package
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;; Bootstrap use-package
;; Install use-package if it's not already installed
;; use-package is used to configure the rest of hte packages
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; From use-package README
(eval-when-compile
  (require 'use-package))

(setq-default indent-tabs-mode nil)

;; Turn off GUI elements
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-visual-line-mode 1)

;; Window screen size\position
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (when window-system
    (progn
      (set-frame-position (selected-frame) 100 0)
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
           (add-to-list 'default-frame-alist (cons 'width 120))
           (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a hundred pixels or so
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist
         (cons 'height (/ (- (x-display-pixel-height) 100)
                             (frame-char-height)))))))

(set-frame-size-according-to-resolution)

;; Use y\n for answers not yes\no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Terminal Setup
;; TODO: Adjust this for different OSes
(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)
;; Turn off highlight line mode in terminal
(add-hook 'term-mode-hook (lambda ()
                            (setq-local global-hl-line-mode nil)))
;; Key binding for ansi-term
(global-set-key (kbd "<s-return>") 'ansi-term)

;; Kill the terminal buffer on exit
(defadvice term-handle-exit
  (after term-kill-buffer-on-exit activate)
  (kill-buffer))

;; Theme tweaks
(global-hl-line-mode t)

;; Line numbers
(setq display-line-numbers-type 'relative)

(if (version<= emacs-version "26.0.50")
  (global-linum-mode 1)
  (global-display-line-numbers-mode 1))

;; Turn off bell sounds
(setq ring-bell-function 'ignore)

;; Turn off auto-save and backups
(setq make-backup-files nil)
(setq auto-save-default nil)

;; try
(use-package try
  :ensure t)

;; which-key
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Color theme (Dracula)
(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t))

;; EditorConfing
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;; Evil mode
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))
(use-package evil-surround
  :after evil
  :ensure t
  :config
  (global-evil-surround-mode 1))
(use-package evil-matchit
  :after evil
  :ensure t
  :config
  (global-evil-matchit-mode 1))

;; Org mode
(use-package org
  :ensure t)
(use-package org-bullets
  :ensure t)

;; Ace Windows
(use-package ace-window
  :ensure t
  :config
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
      '(aw-leading-char-face
         ((t (:inherit ace-jump-face-foreground :height 1.5)))))))

;; Ido mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Markdown Mode
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("\\.md\\'" . gfm-mode)
          ("\\.markdown\\'" . gfm-mode))
  :init (setq markdown-command "pandoc"))

;; ibuffer
;; Force ibuffer in all situations
;;(defalias 'list-buffers 'ibuffer)

;; ibuffer
;;(global-set-key (kbd "C-x C-b") 'ibuffer)

;; DO NOT MANUALLY EDIT BELOW HERE
;; Settings managed by Emacs

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
  '(package-selected-packages
     (quote
       (evil-collection tabbar ace-window evil try which-key editorconfig use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 1.5)))))
