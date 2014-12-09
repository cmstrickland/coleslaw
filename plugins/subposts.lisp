(defpackage :coleslaw-subposts
  (:use :cl)
  (:export #:enable)
  (:import-from :coleslaw
                #:post
                #:discover
                #:find-all
                #:publish
                #:add-document
                #:*config*
                #:read-content
                #:construct
                #:repo
                #:file
                #:do-files
                #:write-document))

(in-package :coleslaw-subposts)

(defclass subpost (post)
  ((type :initarg :type :reader post-type))
  (:default-initargs :type "standard-post" :title "title"))

(defmethod publish ((doc-type (eql (find-class 'subpost))))
  (dolist (subpost (find-all 'subpost))
    (write-document subpost)))


(defmethod discover ((doc-type (eql (find-class 'post))))
  (format t "Ignoring type :post overridden by subpost plugin~%"))

(defmethod discover ((doc-type (eql (find-class 'subpost))))
  (let ((file-type (format nil "~(~A~)" 'post)))
    (do-files (file (repo *config*) file-type)
      (let ((obj (construct 'subpost (read-content file))))
        (add-document obj)))))


(defun enable ())
