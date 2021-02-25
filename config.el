;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; (setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq user-full-name "Carlos Espinosa-Ponce"
      user-mail-address "cespinosa@astro.unam.mx")


(setq doom-font (font-spec :family "Hack Nerd Font" :size 16 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Hack Nerd Font" :size 18))

(setq doom-theme 'doom-one)

(setq org-directory "/home/espinosa/Google_Drive/fractaliusfciencias/Org/")

(setq display-line-numbers-type 'relative)

(setq
 fill-column 80 ; Set width for automatic line breaks
 tab-width 4    ; Set width for tabs
)

(use-package! nyan-mode
   :custom
   (nyan-cat-face-number 4)
   (nyan-animate-nyancat t)
   :hook
   (doom-modeline-mode . nyan-mode))
;; Python interpreter
(setq python-shell-interpreter "/home/espinosa/anaconda3/bin/python3")

;; Conda config
(setq conda-anaconda-home "/home/espinosa/anaconda3/")

;; Org
  (setq private-directory "/home/espinosa/Google_Drive/fractaliusfciencias/Org/")
  (setq task-file (concat private-directory "task.org"))
  (setq schedule-file (concat private-directory "schedule.org")) ;
(defun espinosa/get-today-diary ()
  (concat private-directory
          (format-time-string "diary/%Y/%m/%Y-%m-%d.org" (current-time))))

(defun espinosa/get-yesterday-diary ()
  (concat private-directory
          (format-time-string "diary/%Y/%m/%Y-%m-%d.org" (time-add (current-time) (* -24 3600)))))

(defun espinosa/get-diary-from-cal ()
  (concat private-directory
          (format-time-string "diary/%Y/%m/%Y-%m-%d.org"
                              (apply 'encode-time (parse-time-string (concat (org-read-date) " 00:00"))))))

(defun espinosa/open-org-file (fname)
  (switch-to-buffer (find-file-noselect fname)))

(defun espinosa/org-get-time ()
  (format-time-string "<%H:%M>" (current-time)))

(defun espinosa/code-metadata ()
  (concat ":" (projectile-project-name) ":"))

(defun espinosa/org-clock-out-and-save-when-exit ()
  "Save buffers and stop clocking when kill emacs."
  (ignore-errors (org-clock-out) t)
  (save-some-buffers t))

(defun espinosa/task-clocked-time ()
  "Return a string with the clocked time and effort, if any"
  (interactive)
  (let* ((clocked-time (org-clock-get-clocked-time))
         (h (truncate clocked-time 60))
         (m (mod clocked-time 60))
         (work-done-str (format "%d:%02d" h m)))
    (if org-clock-effort
        (let* ((effort-in-minutes
                (org-duration-to-minutes org-clock-effort))
               (effort-h (truncate effort-in-minutes 60))
               (effort-m (truncate (mod effort-in-minutes 60)))
               (effort-str (format "%d:%02d" effort-h effort-m)))
          (format "%s/%s" work-done-str effort-str))
      (format "%s" work-done-str))))
(after! org (setq org-hide-emphasis-markers t))
(after! org
  (setq org-agenda-start-day "-3d")
  (setq org-src-fontify-natively t)
    (setq org-confirm-babel-evaluate nil)
    (setq org-clock-out-remove-zero-time-clocks t)
    (setq org-startup-folded 'content)
    (setq org-columns-default-format "%50ITEM(Task) %5TODO(Todo) %10Effort(Effort){:} %10CLOCKSUM(Clock) %2PRIORITY %TAGS")
    (setq org-agenda-columns-add-appointments-to-effort-sum t)
    (setq org-agenda-span '10)
    (setq org-agenda-log-mode-items (quote (closed clock)))
    (setq org-agenda-clockreport-parameter-plist
      '(:maxlevel 5 :block t :tstart t :tend t :emphasize t :link t :narrow 80 :indent t :formula nil :timestamp t :level 5 :tcolumns nil :formatter nil))
    (setq org-global-properties (quote ((
      "Effort_ALL" . "00:05 00:10 00:15 00:30 01:00 01:30 02:00 02:30 03:00"))))
    (setq org-agenda-files (quote (
       "/home/espinosa/Google_Drive/fractaliusfciencias/Org/task.org"
       "/home/espinosa/Google_Drive/fractaliusfciencias/Org/routine.org"
       "/home/espinosa/Google_Drive/fractaliusfciencias/Org/schedule.org")))
    (setq org-agenda-current-time-string "← now")
    (setq org-agenda-time-grid ;; Format is changed from 9.1
          '((daily today require-timed)
            (0900 01000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2100 2200 2300 2400)
            "-"
            "────────────────"))
    (setq org-todo-keyword-faces
          '(("WAIT" . (:foreground "#6272a4":weight bold))
            ("NEXT"   . (:foreground "#f1fa8c" :weight bold))
            ("CARRY/O" . (:foreground "#6272a4" :background "#373844" :weight bold))))
  )

(after! org
  (add-to-list 'org-capture-templates
          ;; '(("tweet" "Write down the thoughts of this moment with a timestamp." item
          ;;    (file+headline espinosa/get-today-diary "Log")
          ;;    "%(espinosa/org-get-time) %? \n")
            ;; memo
           '(("memo" "Memorize something in the memo section of today's diary." entry
             (file+headline espinosa/get-today-diary "Memo")
             "** %? \n"
             :unnarrowed 1)
            ;; tasks
            ("inbox" "Create a general task to the inbox and jump to the task file." entry
             (file+headline "/home/espinosa/Google_Drive/fractaliusfciencias/Org/task.org" "Inbox")
             "** TODO %?"
             :jump-to-captured 1)
            ("interrupt-task" "Create an interrupt task to the inbox and start clocking." entry
             (file+headline "/home/espinosa/Google_Drive/fractaliusfciencias/Org/task.org" "Inbox")
             "** TODO %?"
             :jump-to-captured 1 :clock-in 1 :clock-resume 1)
            ("hack-emacs" "Collect hacking Emacs ideas!" item
             (file+headline "/home/espinosa/Google_Drive/fractaliusfciencias/Org/task.org" "Hacking Emacs")
             "- [ ] %?"
             :prepend t)
            ("private-schedule" "Add an event to the private calendar." entry
             (file+olp schedule-file "Calendar" "2021" "Private")
             "** %?\n   SCHEDULED: <%(org-read-date)>\n"
             :prepend t)
            ("work-schedule" "Add an event to the work calendar." entry
             (file+olp schedule-file "Calendar" "2021" "Work")
             "** %?\n   SCHEDULED: <%(org-read-date)>\n")
            ("store-link" "Store the link of the current position in the clocking task." item
             (clock)
             "- %A\n"
             :immediate t :prepend t)
            ;; code-reading
            ("code-link" "Store the code reading memo to today's diary with metadata." entry
             (file+headline espinosa/get-today-diary "Code")
             ;;(file+headline ladicle/get-today-diary "Code")
             "** %? %(espinosa/code-metadata)\n%A\n"))
               )
  )
;; LaTeX
(defvar my/bib-file-location "~/Google_Drive/fractaliusfciencias/Bib/library.bib"
  "Where I keep my bib file")
(after! latex
   (setq TeX-auto-save t)
   (setq TeX-parse-self t)
   (add-hook 'LaTeX-mode-hook
       (lambda ()
         ;;(setq TeX-command-default "latexmk")
         (rainbow-delimiters-mode)
         (company-mode)
         (smartparens-mode)
         (turn-on-reftex)
         (setq reftex-plug-into-AUCTeX t)
         (reftex-isearch-minor-mode)
         (setq TeX-PDF-mode t)
         (setq TeX-source-correlate-method 'synctex)
         (setq TeX-source-correlate-start-server t)))
  )

(use-package ivy-bibtex
  :ensure t
  :bind*
  ("C-c M-c C-r" . ivy-bibtex)
  :config
  (setq bibtex-completion-additional-search-fields '(journal booktitle))
  (setq bibtex-completion-display-formats
        '((article       . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*} ${journal:40}")
          (inbook        . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
          (incollection  . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
          (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
          (t             . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*}")))
  (setq bibtex-completion-bibliography my/bib-file-location)
  (setq bibtex-completion-notes-path "~/Google_Drive/fractaliusfciencias/Bib/ref.org")
  (setq bibtex-completion-pdf-field "File")
  (setq bibtex-completion-library-path '("~/Google_Drive/fractaliusfciencias/Bib/Papers" "~/Google_Drive/fractaliusfciencias/Bib/Libros"))
  (setq ivy-bibtex-default-action #'ivy-bibtex-insert-citation)
  (ivy-set-actions
   'ivy-bibtex
   '(("p" ivy-bibtex-open-any "Open PDF, URL, or DOI")
     ("e" ivy-bibtex-edit-notes "Edit notes")))
  (defun bibtex-completion-open-pdf-external (keys &optional fallback-action)
    (let ((bibtex-completion-pdf-open-function
           (lambda (fpath) (start-process "evince" "*helm-bibtex-evince*" "/usr/bin/evince" fpath))))
      (bibtex-completion-open-pdf fallback-action)))
  (ivy-bibtex-ivify-action bibtex-completion-open-pdf-external ivy-bibtex-open-pdf-external)
  (ivy-add-actions
   'ivy-bibtex
   '(("P" ivy-bibtex-open-pdf-external "Open PDF file in external viewer (if present)")))
  (setq bibtex-completion-pdf-symbol "⌘")
  (setq bibtex-completion-notes-symbol "✎")
)

;; writing tool
(use-package academic-phrases :ensure t)

(use-package reftex
  :ensure t
  :defer t
  :config
  (setq reftex-cite-prompt-optional-args t)
)

(use-package synosaurus
  :diminish synosaurus-mode
  :init    (synosaurus-mode)
  :config  (setq synosaurus-choose-method 'default) ;; 'ido is default.
  (global-set-key (kbd "C-c M-c s") 'synosaurus-choose-and-replace)
)

(setq wordnut-cmd "/usr/local/WordNet-3.0/bin/wn")

(use-package wordnut
  :bind ("C-c M-c w" . wordnut-lookup-current-word))
