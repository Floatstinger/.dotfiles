;;MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
;;

(unless package-archive-contents
  (package-refresh-contents))

;;Emacs base setup
(tool-bar-mode -1)
(display-line-numbers-mode 1)
(menu-bar-mode -1)
(load-theme 'deeper-blue)
(scroll-bar-mode -1)
(display-time-mode 1)
;; Do not create backup files
(setq make-backup-files nil)

(setq mouse-autoselect-window t
      focus-follows-mouse t)
;;End of Emacs Base Setup

;;Magit
(use-package magit
  :ensure t)
;;

;;Company
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))
;;

;;qml-mode
(use-package qml-mode
  :ensure t
  :mode ("\\.qml\\'" . qml-mode))

;;lsp-mode
(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook (qml-mode . lsp))

;;EXWM configuration
(use-package exwm
 :ensure t
 :config
  (require 'exwm-systemtray)
  (exwm-systemtray-mode 1)
  (setq exwm-systemtray-height 30)
  (exwm-background-mode 1)
  (setq exwm-workspace-number 5)
  ;;Pipewire volume control
  (exwm-input-set-key (kbd "<XF86AudioLowerVolume>")
		      (lambda ()
			(interactive)
			(shell-command "pactl set-sink-volume @DEFAULT_SINK@ -5%")
			(shell-command "pactl get-sink-volume @DEFAULT_SINK@")))
  (exwm-input-set-key (kbd "<XF86AudioRaiseVolume>")
		      (lambda ()
			(interactive)
			(shell-command "pactl set-sink-volume @DEFAULT_SINK@ +5%")
			(shell-command "pactl get-sink-volume @DEFAULT_SINK@")))
  (exwm-input-set-key (kbd "<XF86AudioMute>")
		      (lambda ()
			(interactive)
			(shell-command "pactl set-sink-mute @DEFAULT_SINK@ toggle")
			(shell-command "pactl get-sink-mute @DEFAULT_SINK@")))
  ;; When window "class" updates, use it to set the buffer name
  ;; (add-hook 'exwm-update-class-hook #'efs/exwm-update-class)
  ;; These keys should always pass through to Emacs
  (setq exwm-input-prefix-keys
    '(?\C-x
      ?\C-u
      ?\C-h
      ?\M-x
      ?\M-`
      ?\M-&
      ?\M-:
      ?\C-\M-j  ;; Buffer list
      ?\C-\ ))  ;; Ctrl+Space

  ;; Ctrl+Q will enable the next key to be sent directly
  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

  ;; Set up global key bindings.  These always work, no matter the input state!
  ;; Keep in mind that changing this list after EXWM initializes has no effect.
  (setq exwm-input-global-keys
        `(
          ;; Reset to line-mode (C-c C-k switches to char-mode via exwm-input-release-keyboard)
          ([?\s-r] . exwm-reset)

          ;; Move between windows
          ([s-left] . windmove-left)
          ([s-right] . windmove-right)
          ([s-up] . windmove-up)
          ([s-down] . windmove-down)

	  ;; Toggle fullscreen
	  ([?\s-f] . exwm-layout-toggle-fullscreen)

	  ;; Toggle Tiling/Floating mode
	  ([?\s-t] . exwm-floating-toggle-floating)

          ;; Launch applications via shell command
          ([?\s-&] . (lambda (command)
                       (interactive (list (read-shell-command "Run: ")))
                       (start-process-shell-command command nil command)))

          ;; Switch workspace
          ([?\s-w] . exwm-workspace-switch)

          ;; 's-N': Switch to certain workspace with Super (Win) plus a number key (0 - 9)
          ,@(mapcar (lambda (i)
                      `(,(kbd (format "s-%d" i)) .
                        (lambda ()
                          (interactive)
                          (exwm-workspace-switch-create ,i))))
                    (number-sequence 0 9))))
  ;;Buffer namings
  (add-hook 'exwm-update-class-hook
	    (lambda ()
	      (exwm-workspace-rename-buffer exwm-class-name)))
  (exwm-enable))
;;End of EXWM Setup

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
