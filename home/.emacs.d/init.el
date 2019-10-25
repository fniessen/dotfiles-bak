;;; init.el --- Emacs configuration file

;; Copyright (C) 2012-2019 Fabrice Niessen

;;; Commentary:

;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(ignore-errors
  (package-initialize))

(message "(Info) Loading `%s'..." load-file-name)

;;* Load path ----------------------------------------------------------------

;; Org mode (reverse order, so that the Org lisp directory will be found
;; before the Org contrib lisp directory)
;; (add-to-list 'load-path "~/Public/Repositories/org-mode/testing")
;; (add-to-list 'load-path "~/Public/Repositories/org-mode/contrib/lisp") ; htmlize
;; (add-to-list 'load-path "~/Public/Repositories/org-mode/lisp")

;; Directory containing additional Emacs Lisp packages (from the Internet).
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; (add-to-list 'load-path "~/.emacs.d/site-lisp/ecb-2.40")

;; (add-to-list 'load-path "~/src/emacs-load-time")
;; (require 'emacs-load-time)
;; (setq elt-verbose nil) ;; <<<<<<<<<<

;;* 48 Customization ---------------------------------------------------------

;; The default font should be able to display the following UTF-8 characters:
;; - white right-pointing triangle (indicating a collapsed Org headline)
;; - `boxquote' (side and corners)
;; - `calfw'

;; Set default font for all frames.
(when (and (string-match "GNU Emacs" (version))
           (display-graphic-p))         ; Detect whether Emacs is running in
                                        ; a text-only terminal.
  (cond
   ((and (font-info "Consolas")
         (or (eq system-type 'windows-nt)
             (eq system-type 'cygwin)))
    (set-frame-font "Consolas-9" nil t))
   ;; ((font-info "Courier New")
   ;;  (set-frame-font "Courier New-9" nil t))
   ((font-info "Hack")
    (set-frame-font "Hack-8" nil t))
   ((font-info "DejaVu Sans Mono")
    (set-frame-font "DejaVu Sans Mono-10" nil t))
   ;; ((font-info "Lucida Sans Typewriter")
   ;;  (set-frame-font "Lucida Sans Typewriter-9" nil t))
   ;; ((font-info "Lucida Console")
   ;;  (set-frame-font "Lucida Console-9" nil t))
   ))

;; Other monospaced fonts to look at (with many UTF-8 chars):
;; - Source Code Pro (!)
;; - Free Monospaced
;; - Inconsolata

;; - Droid Sans Mono
;; - Menlo (!)
;; - Monaco
;; - Ubuntu Mono

;;* 00 Emacs Leuven ----------------------------------------------------------

;; (setq leuven-load-chapter-0-debugging nil)

;; (setq leuven-load-chapter-48-packages nil)
;; (setq leuven-load-chapter-1-screen nil)
;; (setq leuven-load-chapter-6-exiting nil)
;; (setq leuven-load-chapter-7-basic nil)
;; (setq leuven-load-chapter-8-minibuffer nil)
;; (setq leuven-load-chapter-10-help nil)
;; (setq leuven-load-chapter-11-mark nil)
;; (setq leuven-load-chapter-12-killing nil)
;; (setq leuven-load-chapter-13-registers nil)
;; (setq leuven-load-chapter-14-display nil)
;; (setq leuven-load-chapter-15-search nil)
;; (setq leuven-load-chapter-16-fixit nil)
;; (setq leuven-load-chapter-17-keyboard-macros nil)
;; (setq leuven-load-chapter-18-files nil)
;; (setq leuven-load-chapter-19-buffers nil)
;; (setq leuven-load-chapter-20-windows nil)
;; (setq leuven-load-chapter-21-frames nil)
;; (setq leuven-load-chapter-22-international nil)
;; (setq leuven-load-chapter-23-major-and-minor-modes nil)
;; (setq leuven-load-chapter-24-indentation nil)
;; (setq leuven-load-chapter-25-text nil)       ; XXX Loads Org at startup, if 25 commented and 27 uncommented!
;; (setq leuven-load-chapter-25.10-org-mode nil)
;; (setq leuven-load-chapter-25.11-tex-mode nil)
;; (setq leuven-load-chapter-26-programs nil)
;; (setq leuven-load-chapter-27-building nil)
;; (setq leuven-load-chapter-28-maintaining nil)
;; (setq leuven-load-chapter-29-abbrevs nil)
;; (setq leuven-load-chapter-30-dired nil)
;; (setq leuven-load-chapter-31-calendar-diary nil)
;; (setq leuven-load-chapter-32-sending-mail nil)
;; (setq leuven-load-chapter-34-gnus nil)
;; (setq leuven-load-chapter-36-document-view nil)
;; (setq leuven-load-chapter-38-shell nil)
;; (setq leuven-load-chapter-39-emacs-server nil)
;; (setq leuven-load-chapter-40-printing nil)
;; (setq leuven-load-chapter-41-sorting nil)
;; (setq leuven-load-chapter-44-saving-emacs-sessions nil)
;; (setq leuven-load-chapter-46-hyperlinking nil)
;; (setq leuven-load-chapter-47-amusements nil)
;; (setq leuven-load-chapter-49-customization nil)
;; (setq leuven-load-chapter-AppG-ms-dos nil)
;; (setq leuven-load-chapter-XX-emacs-display nil)
;; (setq leuven-load-chapter-99-debugging nil)

;; (setq leuven-verbose-loading t)

;; (setq leuven-excluded-packages
;;       '(useless-package
;;         other-annoying-package))

(if (file-exists-p "~/.dotfiles/plugins/emacs-leuven")
    (add-to-list 'load-path (expand-file-name "~/.dotfiles/plugins/emacs-leuven"))
  (add-to-list 'load-path (expand-file-name "~/2-Output/emacs-leuven")))
;; (let ((file-name-handler-alist nil))    ; Easy little known step to speed up
;;                                         ; Emacs start up time.
;; FIXME: When activated, breaks windows-path interpretation of 'es' results...
(when (locate-library "emacs-leuven")
  (require 'emacs-leuven))
;; )

(let ((init-local "~/.emacs.d/init_local.el"))
  (when (file-exists-p init-local)
    (load-file init-local)))

;; This is for the sake of Emacs.
;; Local Variables:
;; ispell-local-dictionary: "american"
;; End:

;;; init.el ends here
