;;; .gnus --- Gnus configuration file

;; Copyright (C) 2012-2019 Fabrice Niessen

;;; Commentary:

;;; Code:

(require 'gnus-leuven)

(if (file-exists-p "~/.gnus_local")
    (load-file "~/.gnus_local")
  (message "~/.gnus_local NOT found")
  (sit-for 1.5))

(if (file-exists-p "~/.authinfo")
    (message "~/.authinfo found")
  (message "~/.authinfo NOT found")
  (sit-for 1.5))

;;; .gnus ends here
