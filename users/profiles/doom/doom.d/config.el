;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(defun footnote-template ()
  (if (and
       (string=
        (substring
         (thing-at-point 'line t)
         0
         4)
        "[fn:")
       (string=
        (substring
         (thing-at-point 'line t)
         -3
         nil)
        "]\n")
       )
      (lambda () (interactive)
        (insert "[[][]] ([[][archived]])")
        (dotimes
            (i 19)
          (backward-char)))))

(defmacro :function (&rest body)
  (if (->> body length (< 1))
      `(lambda () ,@body)
    (pcase (car body)
      ;; command symbol
      ((and v (pred commandp))
       `(lambda () (call-interactively (quote ,v))))
      ;; function symbol
      ((and v (pred symbolp))
       `(lambda () (,v)))
      ;; quoted command symbol
      ((and v (pred consp) (guard (eq 'quote (car v))) (pred commandp (cadr v)))
       `(lambda () (call-interactively ,v)))
      ;; quoted function symbol
      ((and v (pred consp) (guard (eq 'quote (car v))))
       `(lambda () (,(cadr v))))
      ;; body forms
      (_ `(lambda () ,@body) ))))

(defmacro :command (&rest body)
  (if (->> body length (< 1))
      `(lambda () (interactive) ,@body)
    (pcase (car body)
      ;; command symbol
      ((and v (pred commandp))
       `(lambda () (interactive) (call-interactively (quote ,v))))
      ;; function symbol
      ((and v (pred symbolp))
       `(lambda () (interactive) (,v)))
      ;; quoted command symbol
      ((and v (pred consp) (guard (eq 'quote (car v))) (pred commandp (cadr v)))
       `(lambda () (interactive) (call-interactively ,v)))
      ;; quoted function symbol
      ((and v (pred consp) (guard (eq 'quote (car v))))
       `(lambda () (interactive) (,(cadr v))))
      ;; body forms
      (_ `(lambda () (interactive) ,@body) ))))

(defmacro :after (package &rest body)
  "A simple wrapper around `with-eval-after-load'."
  (declare (indent defun))
  `(with-eval-after-load ',package ,@body))

(defmacro :hook (hook-name &rest body)
  "A simple wrapper around `add-hook'"
  (declare (indent defun))
  (let* ((hook-name (format "%s-hook" (symbol-name hook-name)))
         (hook-sym (intern hook-name))
         (first (car body))
         (local (eq :local first))
         (body (if local (cdr body) body))
         (first (car body))
         (body (if (consp first)
                   (if (eq (car first) 'quote)
                       first
                     `(lambda () ,@body))
                 `',first)))
    `(add-hook ',hook-sym ,body nil ,local)))

(defmacro :push (sym &rest body)
  (declare (indent defun))
  (if (consp body)
      `(setq ,sym (-snoc ,sym ,@body))
    `(add-to-list ,sym ,body)))

(defmacro :bind (key &rest body)
  (declare (indent defun))
  (pcase key
    ;; kbd string resolving symbol
    ((and k (pred symbolp) (pred boundp) (guard (stringp (eval key))))
     `(global-set-key (kbd ,(eval key)) ,(eval `(:command ,@body))))
    ;; partial mode symbol
    ((pred symbolp)
     (let ((mode (intern (format "%s-map" key)))
           (key (eval (car body)))
           (body (eval `(:command ,@(cdr body)))))
       `(define-key ,mode (kbd ,key) ,body)))
    ;; global binding
    (_ `(global-set-key (kbd ,key) ,(eval `(:command ,@body))))))

(defun :enable-minor-mode (my-pair)
  "Enable minor mode if filename match the regexp.  MY-PAIR is a cons cell (regexp . minor-mode)."
  (if (buffer-file-name)
      (if (string-match (car my-pair) buffer-file-name)
      (funcall (cdr my-pair)))))

(setq user-full-name "LiquidZulu"
      user-mail-address "liquidzulu@pm.me")

(setq org-image-actual-width 500)

(setq doom-theme 'doom-one)

(custom-set-faces!
 '(rainbow-delimiters-depth-1-face :foreground "#FF5F5C")
 '(rainbow-delimiters-depth-2-face :foreground "#FFF1C7")
 '(rainbow-delimiters-depth-3-face :foreground "#5E807F")
 '(rainbow-delimiters-depth-4-face :foreground "#33FFEB")
 '(rainbow-delimiters-depth-5-face :foreground "#FF5D38")
 '(rainbow-delimiters-depth-6-face :foreground "#FFC72E")
 '(rainbow-delimiters-depth-7-face :foreground "#75FFD6")
 '(rainbow-delimiters-depth-8-face :foreground "#2996F5")
 '(rainbow-delimiters-depth-9-face :foreground "#FFFB7A")
 '(outline-1 :font "Cubano:pixelsize=32")
 '(outline-2 :font "Cubano:pixelsize=30")
 '(outline-3 :font "Cubano:pixelsize=28")
 '(outline-4 :font "Cubano:pixelsize=28")
 '(outline-5 :font "Cubano:pixelsize=28")
 '(outline-6 :font "Cubano:pixelsize=28")
 '(outline-7 :font "Cubano:pixelsize=28")
 '(outline-8 :font "Cubano:pixelsize=28")
 )

; https://github.com/doomemacs/doomemacs/issues/5948#issuecomment-1004253858
(setq
 normal-font (cl-find-if #'doom-font-exists-p
                         '(
                           "mononoki"
                           "JetBrainsMono Nerd Font"
                           "NotoSerif Nerd Font"
                           "monospace")))
(setq
 doom-font      (font-spec :family normal-font :size 24)
 doom-big-font  (font-spec :family normal-font :size 32))

(setq org-export-headline-levels 512)

(setq org-startup-with-inline-images t)

(setq org-image-actual-width 500)

(setq display-line-numbers-type 'relative)

(setq delete-by-moving-to-trash t)           ; Delete files to trash
(setq tab-width 4)                            ; Set width for tabs
(setq uniquify-buffer-name-style 'forward)    ; Uniquify buffer names
(setq window-combination-resize t)            ; take new window space from all other windows (not just current)
(setq x-stretch-cursor t)                    ; Stretch cursor to the glyph width

(setq undo-limit 80000000)                    ; Raise undo-limit to 80Mb
(setq evil-want-fine-undo t)                  ; By default while in insert all changes are one big blob. Be more granular
(setq auto-save-default t)                    ; Nobody likes to loose work, I certainly don't
(setq inhibit-compacting-font-caches t)       ; When there are lots of glyphs, keep them in memory
(setq truncate-string-ellipsis "…")          ; Unicode ellispis are nicer than "...", and also save /precious/ space

(delete-selection-mode 1)                  ; Replace selection when inserting text
(setq line-spacing 0.3)                    ; seems like a nice line spacing balance.

(setq auto-save-default t)
(setq auto-save-timeout 20)   ; every 20 secs
(setq auto-save-interval 20)  ; or every 20 keystrokes

(global-prettify-symbols-mode 1)

(require 'paren)
(show-paren-mode 1)
(setq show-paren-delay 0)
(:after xresources
  (set-face-foreground 'show-paren-match (theme-color 'green))
  (set-face-foreground 'show-paren-mismatch "#f00")
  (set-face-attribute 'show-paren-match nil :weight 'extra-bold)
  (set-face-attribute 'show-paren-mismatch nil :weight 'extra-bold))

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

(add-hook 'window-setup-hook #'toggle-frame-maximized)

(defun conf ()
  "Go to config"
  (interactive)
  (dired "~/.nixcfg/users/profiles/doom/doom.d"))

(defun sysconf ()
  "Go to system config"
  (interactive)
  (dired "~/.nixcfg"))

(defun home ()
  "Go to home"
  (interactive)
  (dired "~"))

(defun doc ()
  "Go to home"
  (interactive)
  (dired "~/Documents"))
(defun docs ()
  "Go to home"
  (interactive)
  (dired "~/Documents"))

(defun yt ()
  "Go to yt scripts"
  (interactive)
  (dired "~/Documents/youtube-scripts"))
(defun course ()
  "Go to course scripts"
  (interactive)
  (dired "~/Documents/youtube-scripts/courses"))

(defun notes ()
  "Go to notes"
  (interactive)
  (dired "~/Documents/notes"))

(defun web ()
  "Go to liquidzulu.github.io repo"
  (interactive)
  (dired "~/Documents/liquidzulu.github.io"))
(defun webv ()
  "Go to liquidzulu.github.io repo and open terminal"
  (interactive)
  (dired "~/Documents/liquidzulu.github.io")
  (vterm))

(defun capsaicin ()
  "Go to capsaicin repo"
  (interactive)
  (dired "~/Documents/capsaicin"))

;(setq w32-apps-modifier 'hyper)
;(setq w32-lwindow-modifier 'super)
;(setq w32-rwindow-modifier 'hyper)
(setq zulu-scroll-amount 5)

(map!
 "C-l"          #'beginning-of-line
 "C-u"          #'end-of-line
 "C-n"          #'backward-char
 "C-e"          #'forward-char

 "M-l"          #'previous-line
 "M-u"          #'next-line
 "M-n"          #'backward-word
 "M-e"          #'forward-word

 "M-m"          #'(lambda () (interactive) (dotimes (i zulu-scroll-amount) (scroll-up-line)))
 "M-j"          #'(lambda () (interactive) (dotimes (i zulu-scroll-amount) (scroll-down-line)))

 "C-f"          #'org-footnote-action

 "C-c i i"      #'(lambda () (interactive) (insert "#+CAPTION:\n#+NAME:\n[[./images]]") (backward-char) (backward-char) "Insert image")  ; "insert image"
 "C-C i t r"    #'org-table-create-or-convert-from-region
 "C-C i t e"    #'org-table-create-with-table.el

 "s-b" #'ibuffer
 "s-v" #'vterm

 "M-y" #'yank ; I keep accidently pressing this instead of C-y, and I hate it, it breaks everything

 "C-d" #'doom/delete-frame-with-prompt

 "C-x s" #'ace-swap-window

 "C-x M-s" #'(lambda () (interactive) (save-buffer) (org-babel-tangle))

                                        ;"C-RET"    #'(lambda () (interactive) (+org/insert-item-below) (org-return))

 ;; "C-M-x f a"   ;#'helm-bibtex         ; "find article" : opens up helm bibtex for search.
 ;; "C-M-x o n"   ;#'org-noter           ; "org noter"  : opens up org noter in a headline
 ;; "C-M-x r c i" ;#'org-clock-in        ; "routine clock in" : clock in to a habit.
 ;; "C-M-x c b"   ;#'beacon-blink        ; "cursor blink" : makes the beacon-blink
 )

(map! :map markdown-mode-map
      "M-n" #'backward-word) ; used to be markdown-next-link, which breaks the locomotion

(add-to-list 'auto-mode-alist '("\\.mdx\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

(defun doom-modeline-conditional-buffer-encoding ()
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))
(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

(org-babel-do-load-languages
      'org-babel-load-languages
      '(
        (C . t)
        (js . t)))

(define-derived-mode astro-mode web-mode "astro")
(setq auto-mode-alist
      (append '((".*\\.astro\\'" . astro-mode))
              auto-mode-alist))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration
               '(astro-mode . "astro"))

  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("astro-ls" "--stdio"))
                    :activation-fn (lsp-activate-on "astro")
                    :server-id 'astro-ls)))

(add-hook 'web-mode-hook #'(lambda ()
                            (:enable-minor-mode
                             '("\\.astro?\\'" . prettier-js-mode))))

(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'astro-mode-hook 'prettier-js-mode)

(setq auto-mode-alist
      (append '((".*\\.pyx\\'" . cython-mode))
              auto-mode-alist))

(require 'ox-json)

                                        ;(add-hook 'org-mode-hook #'org-make-toc-mode) ; automatically update toc
