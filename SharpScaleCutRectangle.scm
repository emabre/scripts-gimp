(define (sharp-scale-cut-rectangle filename-in
                                   filename-out
                                   x-upper-left
                                   y-upper-left
                                   x-lower-right
                                   y-lower-right
                                   new-width
                                   new-height
                                   radius
                                   amount
                                   threshold)

  (let* ((image      (car (gimp-file-load RUN-NONINTERACTIVE filename-in "")))
         ;(drawable   (car (gimp-image-active-drawable image)))
        )

     (gimp-image-select-rectangle
       image
       0
       x-upper-left
       y-upper-left
       (- x-lower-right x-upper-left)
       (- y-upper-left y-lower-right))
     (gimp-edit-copy (car (gimp-image-get-active-drawable image)))
   )

   (let* ((image (car (gimp-edit-paste-as-new)))
          ;(drawable (car (gimp-image-get-active-drawable image)))
         )
      (gimp-image-scale image new-width new-height)
      (plug-in-unsharp-mask RUN-NONINTERACTIVE
                            0 ; unused
                            (car (gimp-image-get-active-drawable image))
                            radius
                            amount
                            threshold)
      (gimp-file-save   RUN-NONINTERACTIVE
                        image
                        (car (gimp-image-get-active-drawable image))
                        filename-out
                        "")

   )
     ;(gimp-image-scale image width height)
)
