; This program is free software; you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation; either version 2 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <http://www.gnu.org/licenses/>.
(define (cut-rectangle filename-in filename-out x-upper-left y-upper-left x-lower-right y-lower-right)

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
          (drawable (car (gimp-image-get-active-drawable image)))
         )
      (gimp-file-save   RUN-NONINTERACTIVE image drawable filename-out "")
   )
     ;(gimp-image-scale image width height)
)
