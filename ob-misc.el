;;; Code --- summary:
;; Author: Dodge W. Coates
;; A miscellaneous assortment of functions for org babel editing
;;; Commentary:
;;
;;; Code:

(require 'org)

(defun org-goto-src-headers ()
  "Move point to the first header of the source block currently containing point."
  (interactive)
  (org-babel-goto-src-block-head)
  (beginning-of-line)
  (unless (re-search-forward "#\\+begin_src[ ]+?" (line-end-position))
    (error "Error: Couldn't find source header.  This shouldn't happen")))

(defun org-get-src-headers ()
  "Get the src headers for current source block."
  (interactive)
  (save-excursion
    (org-goto-src-headers)
    (buffer-substring-no-properties (point) (line-end-position))))

(defun org-propertize-headers (&optional headers)
  "Propertize org block HEADERS string correctly for display.
HEADERS defaults to those of the current org block."
  (let ((headers (or headers (org-get-src-headers))))
    (mapconcat (lambda (header-element)
                 (propertize (concat header-element " ") 'face
                             (if (string-match ":[[[:alnum:]-*]]*" header-element)
                                 '(:foreground "green3")
                               '(foreground "gray20"))))
               (split-string (org-get-src-headers) "[ ]+")
               " ")))

(defun org-edit-src-headers (headers)
  "Edit the org block HEADERS for block currently enclosing point."
  (interactive (list
                (let ((minibuffer-allow-text-properties t))
                  (read-from-minibuffer
                   "Block headers: "
                   (org-propertize-headers)))))
  (save-excursion
    (org-goto-src-headers)
    (delete-region (point) (line-end-position))
    (insert headers)))

(defun org-show-headers ()
  "Display in the minibuffer the headers for current org block."
  (interactive)
  (message "%s: %s"
           (propertize "Source Headers" 'face '(:foreground "orange"))
           (org-propertize-headers (org-get-src-headers))))

(provide 'ob-misc)

;;; ob-misc.el ends here
