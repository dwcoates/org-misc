;;; Code --- summary:
;;
;; Author: Dodge W. Coates
;; A miscellaneous assortment of functions for org agenda
;;
;;; Commentary:
;;
;;; Code:

(require 'org)

(defun org-switch-to-agenda (&optional redo)
  "Swtich to `org-agenda' buffer if it exists, else create one.
If an agenda needs to be created, it will be a weekly view.
If REDO is non-nil, rebuild the agenda view after visiting it."
  (interactive)
  (let ((buf (get-buffer "*Org Agenda*")))
    (if buf
        (progn
          (switch-to-buffer-other-window buf)
          (when redo (org-agenda-redo)))
      (org-agenda nil "a"))))

(defun org-get-agenda ()
  "Same as `org-switch-to-agenda' with non-nil REDO."
  (interactive)
  (org-switch-to-agenda t))

(provide 'agenda-misc)

;;; ag-misc.el ends here
