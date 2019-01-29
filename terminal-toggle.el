;;; terminal-toggle.el --- simple pop-up terminal -*- lexical-binding: t; -*-

;; Copright (C) 2019 Mehmet Tekman <mtekman89@gmail.com>

;; Author: Mehmet Tekman
;; URL: https://github.com/mtekman/terminal-toggle.el
;; Keywords: outlines
;; Package-Requires: ((emacs "24") (popwin "1.0.0"))
;; Version: 0.1

;;; Commentary:

;; A simple terminal that pops-up (bottom/top/left/right) and then removes
;; itself when it loses focus without killing the buffer. Essentially it is
;; a simple hide/show for a terminal.

(require 'popwin)

;;; Code:

(defvar terminal-toggle--term-name
  "Name of buffer to hide/show"
  "*ansi-term*")

(defcustom terminal-toggle--term-command "ansi-term"
  "Terminal command to launch"
  :type 'string)

(defcustom terminal-toggle--term-shell "/usr/bin/zsh"
  "Terminal shell to launch"
  :type 'string)

(defun terminal-toggle-is-open ()
  "Terminal exists"
  (get-buffer term-name))

(defun terminal-toggle-is-showing ()
  "Terminal state (whether is visible)"
  (get-buffer-window term-name))

(defun terminal-toggle-launch ()
  "Launch ansi terminal"
  (terminal-toggle--term-command terminal-toggle--term-shell))

(defun terminal-toggle-set-visible ()
  "Show an already opened terminal"
  (popwin:popup-buffer term-name))

(defun terminal-toggle-set-hidden ()
  "Hide the terminal"
  (delete-window (get-buffer-window term-name)))

;;;###autoload
(defun terminal-toggle ()
  "Show/launch or hide terminal"
  (interactive)
  (if (terminal-toggle-is-open)
      (if (terminal-toggle-is-showing)
          (terminal-toggle-set-hidden)
        (terminal-toggle-set-visible))
    (progn (terminal-toggle-launch)
           (terminal-toggle-set-visible))))

(provide 'terminal-toggle)

;;; terminal-toggle.el ends here
