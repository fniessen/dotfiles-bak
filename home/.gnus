;;; .gnus --- Gnus configuration file

;; Copyright (C) 2012-2019 Fabrice Niessen

;;; Commentary:

;;; Code:

(require 'gnus-leuven)

(when (file-exists-p "~/.gnus_local")
  (load-file "~/.gnus_local"))

;;; .gnus ends here
