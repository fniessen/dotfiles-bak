;;; sword-mode.el -- Rule language Sword editing mode

;; Copyright (c) 2011-2014 Mission Critical IT

;;; Commentary:

;; Goals:
;; - sytax highlighting
;; - completion
;; - indentation

;; What it does now:
;; - Syntax highlighting

;;; Code:

(setq sword-highlights
  '(
    ;; SWORD keywords
    ("\\<\\(all\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(and\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(as\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(class\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(exactly\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(extends\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(function of\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(has\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(if\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(import\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(inverse\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(is\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(is a\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(keys\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(max\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(min\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(ontology\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(prefix\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(range\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(required\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(rule\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(single\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(some\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(symmetric\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(then\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(transitive\\)\\>" 1 font-lock-keyword-face t)
    ("\\<\\(with\\)\\>" 1 font-lock-keyword-face t)

    ;; SWORD predicates
    ("\\<\\(\\S-*?:\\S-+?\\)\\>" 1 font-lock-function-name-face t)

    ;; Specific highlight for rule and class ids
    ("\\<rule\\s-+\\(.+?\\)\\>" 1 font-lock-type-face t)
    ("\\<class\\s-+\\(.+?\\)\\>" 1 font-lock-type-face t)

    ;; Specific highlight for predefined namespaces
    ("\\<\\(rdfs:.+?\\)\\>" 1 font-lock-builtin-face t)
    ("\\<\\(xsd:.+?\\)\\>" 1 font-lock-builtin-face t)
    ("\\<\\(swrlb:.+?\\)\\>" 1 font-lock-builtin-face t)
    ("\\<\\(hedwig:.+?\\)\\>" 1 font-lock-builtin-face t)

    ;; Full URIs and literal tags
    ("\\(<.+?>\\)" 1 font-lock-preprocessor-face t)
    ("\\(@.+?\\)\\>" 1 font-lock-preprocessor-face t)

    ;; Strings
    ("\\(\\\".+?\\\"\\)" 1 font-lock-string-face t)

    ;; Variables
    ("\\(\\\?.*?\\)\\>" 1 font-lock-variable-name-face t)

    ;; Comments
    ; Bug: some trailing characters are highlighted; restricting comments regexp
    ; ("\\(#.*\\)" 1 font-lock-comment-face t)
    ("^\\s-*\\(#.*\\)" 1 font-lock-comment-face t)))

(define-derived-mode sword-mode prog-mode "Sword"
  "Major mode for editing Sword code."

  ;; setup tab key not working :/
  ;; (setq c-basic-offset 4)

  ;; common initialization for Sword mode
  (make-local-variable 'comment-start)
  (setq comment-start "#")

  ;; syntax highlighting
  (setq font-lock-defaults '(sword-highlights))

  ;; comments: `# ...'
  (modify-syntax-entry ?# "< b" sword-mode-syntax-table)
  (modify-syntax-entry ?\n "> b" sword-mode-syntax-table)

  ;; remove the interpretation of some chars as word delimiter
  (modify-syntax-entry ?? "w")
  (modify-syntax-entry ?_ "w")
  (modify-syntax-entry ?: "w")
  (modify-syntax-entry ?- "w"))

;; enable auto-complete-mode automatically
(when (featurep 'auto-complete)
  (add-to-list 'ac-modes 'sword-mode))

;; enable auto-highlight-symbol-mode automatically
(when (featurep 'auto-highlight-symbol)
  (add-to-list 'ahs-modes 'sword-mode))

(provide 'sword-mode)

;;; sword-mode.el ends here
