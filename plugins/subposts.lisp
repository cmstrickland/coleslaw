(defpackage :coleslaw-subposts
  (:use :cl)
  (:export #:enable)
  (:import-from :coleslaw
                #:post
                #:discover
                #:slugify
                #:render
                #:find-all
                #:publish
                #:add-document
                #:theme-fn
                #:render-text
                #:add-injection
                #:*injections*
                #:*config*
                #:read-content
                #:construct
                #:compute-url
                #:author
                #:repo-dir
                #:file
                #:make-keyword
                #:do-files
                #:write-document))

(in-package :coleslaw-subposts)

(defclass subpost (post)
  ((type :initarg :type :reader post-type))
  (:default-initargs :type "standard-post" :title "title"))

(defmethod initialize-instance :after ((object subpost) &key)
  (with-slots (type)
      (setf type "standard type")))

(defmethod publish ((doc-type (eql (find-class 'subpost))))
  (dolist (subpost (find-all 'subpost))
    (write-document subpost)))

(defmethod discover ((doc-type (eql (find-class 'subpost))))
  (let ((file-type (format nil "~(~A~)" 'post)))
    (do-files (file (repo-dir *config*) file-type)
      (let ((obj (construct 'subpost (read-content file))))
        (print-object obj *standard-output*)
        (add-document obj)))))


(defun enable ())
