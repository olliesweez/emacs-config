;; Enable mouse support
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
  )

;; focus follows mouse
(setq mouse-autoselect-window t)

;; Smooth Scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed t)
(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)

;; Show column number
(column-number-mode 1)
(setq scroll-step 1)

;; highlight paired brace
(show-paren-mode 1)

;; disable scroll bar
(scroll-bar-mode 0)

;; set tab width to 4
(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode nil)

;; disable fringe
(set-fringe-mode 0)

;; turn off bell and visual bell
(setq ring-bell-function 'ignore)

;; Set transparency of emacs
 (defun transparency (value)
   "Sets the transparency of the frame window. 0=transparent/100=opaque"
   (interactive "nTransparency Value 0 - 100 opaque:")
   (set-frame-parameter (selected-frame) 'alpha value))

(transparency 80)

;; dim out of focus buffer
(add-hook 'after-init-hook (lambda ()
                             (when (fboundp 'auto-dim-other-buffers-mode)
                               (auto-dim-other-buffers-mode t))))


(require 'package)
;; Add the Marmalade repo
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; popwin
(require 'popwin)
(popwin-mode 1)

;; Mouse click leaves minibuffer
(defun stop-using-minibuffer ()
  "kill the minibuffer"
  (when (and (>= (recursion-depth) 1) (active-minibuffer-window))
    (abort-recursive-edit)))

(add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(column-number-mode t)
 '(company-backends
   (quote
    (company-irony company-nxml company-css company-eclim company-semantic company-bbdb company-xcode company-ropemacs company-cmake company-capf
                   (company-dabbrev-code company-gtags company-etags company-keywords)
                   company-oddmuse company-files company-dabbrev)))
 '(custom-enabled-themes (quote (sanityinc-tomorrow-bright)))
 '(custom-safe-themes
   (quote
    ("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
 '(fci-rule-color "#2a2a2a")
 '(ns-use-native-fullscreen nil)
 '(send-mail-function nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote reverse) nil (uniquify))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
     (40 . "#e78c45")
     (60 . "#e7c547")
     (80 . "#b9ca4a")
     (100 . "#70c0b1")
     (120 . "#7aa6da")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "#e78c45")
     (200 . "#e7c547")
     (220 . "#b9ca4a")
     (240 . "#70c0b1")
     (260 . "#7aa6da")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "#e78c45")
     (340 . "#e7c547")
     (360 . "#b9ca4a"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; mac switch meta key
(defun mac-switch-meta nil 
  "switch meta between Option and Command"
  (interactive)
  (if (eq mac-option-modifier nil)
      (progn
	(setq mac-option-modifier 'meta)
	(setq mac-command-modifier 'hyper)
	)
    (progn 
      (setq mac-option-modifier nil)
      (setq mac-command-modifier 'meta)
      )
    )
  )
;;(mac-switch-meta)

;; Multiple Cursors
(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Autosaves go ~/.saves dir
(setq backup-directory-alist `(("." . "~/.saves")))
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

;; autocomplete
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(add-to-list 'exec-path "/usr/local/bin")
;;(require 'cc-mode)
;;(require 'semantic)

;; ;;(global-semantic-decoration-mode nil)
;; (global-semantic-highlight-func-mode t)
;; (global-semantic-show-unmatched-syntax-mode t)
;; (global-semanticdb-minor-mode 1)
;; (global-semantic-idle-scheduler-mode 1)

;; (semantic-mode 1)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(add-hook 'c-mode-hook '(lambda ()
                          (company-mode)
                          (irony-mode)
                          (electric-indent-mode)
                          (yas-minor-mode)
                          ))

(add-hook 'c++-mode-hook '(lambda ()
                            (company-mode)
                            (irony-mode)
                            (electric-indent-mode)
                            (yas-minor-mode)
                            ))
;;(add-hook 'c-mode-hook 'eldoc-mode)
(setq company-idle-delay 0.1)

;; window formatting
(setq ns-use-native-fullscreen nil)
;;(set-frame-parameter nil 'fullscreen 'fullboth)
;;(toggle-frame-fullscreen)
(tool-bar-mode -1)
;;(global-set-key (kbd "<f9>") 'toggle-frame-fullscreen)



;; occa mode color support
(load-file "~/.emacs.d/okl-mode.el")


;; disable new window creation
(setq ns-pop-up-frames nil)
