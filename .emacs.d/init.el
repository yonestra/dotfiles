;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; おまじない
(require 'cl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load-path 関連
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; load-path を追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
	(dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
		(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; elispとconfディレクトリをサブディレクトリごとload-pathに追加
(add-to-load-path "elisp" "conf")

(setq load-path (cons "/Applications/Emacs.app/Contents/Resources/site-lisp/" load-path))

;; より下に記述した物が PATH の先頭に追加
(dolist (dir (list
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              ;; "/sw/bin"
              "/usr/local/bin"
              (expand-file-name "~/bin")
              ;; (expand-file-name "~/.emacs.d/bin")
              ))
  
  ;; PATH と exec-path に同じ物を追加
  (when (and (file-exists-p dir) (not (member dir exec-path)))
	(setenv "PATH" (concat dir ":" (getenv "PATH")))
	(setq exec-path (append (list dir) exec-path))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 表示関係
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; タブの表示幅の指定
(setq default-tab-width 4)

;; 選択範囲の色の反転
(setq-default transient-mark-mode t)

;; 背景を黒に
(if window-system (progn
					(set-background-color "Black")       ; 背景色
					(set-foreground-color "White")       ; 前景色
					(set-cursor-color "Yellow")          ; カーソル色
					(set-frame-parameter nil 'alpha 85)  ; 透過具合
					))

;; 行番号を表示
(require 'linum)
(global-linum-mode)

;; 行のハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     ;;(:background "dark state gray"))
     (:background "gray10"
                  :underline "gray24"))
    (((class color)
      (background light))
     (:background "ForestGreen"
                  :underline nil))
    (t ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
;;(setq hl-line-face 'underline)
(global-hl-line-mode)

;; メニューバーにファイルのフルパスを表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; カーソルを点滅
(blink-cursor-mode t)

;; paren: 対応する括弧を光らせる
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'expression)                    ; カッコ内の色も変更
(set-face-background 'show-paren-match-face nil)       ; カッコ内のフェイス
(set-face-underline-p 'show-paren-match-face "yellow") ; カッコ内のフェイス

;; オートセーブ
;; (require 'auto-save-buffers)
;; (run-with-idle-timer 20 t 'auto-save-buffers)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 非表示関係
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; スタートアップメッセージを非表示
(setq inhibit-startup-screen t)
(when window-system
  ;; tool-bar を非表示
  (tool-bar-mode 0)
  ;; scroll-bar を非表示
  (scroll-bar-mode 0))
;; menu-bar を非表示
(menu-bar-mode 0)

;; Emacsからの質問を y/n で回答する
(fset 'yes-or-no-p 'y-or-n-p)

;; バックアップファイルを作らない
(setq backup-inhibited t)

;;複数ウィンドウを開かないようにする
;; (setq ns-pop-up-frames nil)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; キーバインドの割り当て関係
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Macのキーバインドを使う。optionをメタキーにする。
;;(mac-key-mode 1)
;;(setq mac-option-modifier 'meta)

;;シフト押しながらキー移動で範囲選択
(setq pc-select-selection-keys-only t)
(pc-selection-mode 1)

;; C-kで行全体を削除
(setq kill-whole-line t)

;; バッファ全体をインデント
										;(define-key (kbd "C-<f8>") (kbd "C-x h TAB"))

;; "C-m" に newline-and-indent を割り当てる。初期値は newline
(define-key global-map (kbd "C-m") 'newline-and-indent)

;; "M-k" でカレントバッファを閉じる。初期値は kill-sentence
(define-key global-map (kbd "M-k") 'kill-this-buffer)

;; "C-t" でウィンドウを切り替える。初期値は transpose-chars
(define-key global-map (kbd "C-t") 'other-window)

;; Mac の command + → でウィンドウを左右に分割
(define-key global-map (kbd "s-<right>") 'split-window-horizontally)
;; Mac の Command + ↓ でウィンドウを上下に分割
(define-key global-map (kbd "s-<down>") 'split-window-vertically)
;; Mac の Command + w で現在のウィンドを削除
(define-key global-map (kbd "s-w") 'delete-window)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-install 関係
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (install-elisp "http://www.emacswiki.org/emacs/download/auto-install.el")
(when (require 'auto-install nil t)
  ; Emacs Lisp をインストールするディレクトリの指定
  (setq auto-install-directory "~/.emacs.d/elisp/auto-install")
  ; EmacsWiki に登録されている elisp の名前を取得
  ;(auto-install-update-emacswiki-package-name t)
  ; プロキシの設定
  ;(setq url-proxy-services '(("http" . "localhost:8339")))
  ; install-elisp.elとコマンド名を同期
  (auto-install-compatibility-setup))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; anything 関係
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; anything
;; (auto-install-batch "anything")
;; (when (require 'anything nil t)
  (setq
   ;; 候補を表示するまでの時間。デフォルトは0.5
   anything-idle-delay 0.3
   ;; タイプして再描写するまでの時間。デフォルトは0.1
   anything-input-idle-delay 0.2
   ;; 候補の最大表示数。デフォルトは50
   anything-candidate-number-limit 100
   ;; 候補が多いときに体感速度を早くする
   anything-quick-update t
   ;; 候補選択ショートカットをアルファベットに
   anything-enable-shortcuts 'alphabet)

  (when (require 'anything-config nil t)
    ;; root権限でアクションを実行するときのコマンド
    ;; デフォルトは"su"
    (setq anything-su-or-sudo "sudo"))

  (require 'anything-match-plugin nil t)
  (and (equal current-language-environment "Japanese")
       (executable-find "cmigemo")
       (require 'anything-migemo nil t))
  (when (require 'anything-complete nil t)
    ;; M-xによる補完をAnythingで行なう
    ;; (anything-read-string-mode 1)
    ;; lispシンボルの補完候補の再検索時間
    (anything-lisp-complete-symbol-set-timer 150))

  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))

  (when (require 'descbinds-anything nil t)
    ;; describe-bindingsをAnythingに置き換える
    (descbinds-anything-install))

  (require 'anything-grep nil t)

  ;; Command+f で anything
  (define-key global-map (kbd "s-f") 'anything)
  ;; Command+y で anything-show-kill-ring
  (define-key global-map (kbd "s-y") 'anything-show-kill-ring)

  ;; manやinfoを調べるコマンドを作成してみる
  ;; anything-for-document 用のソースを定義
  (setq anything-for-document-sources
      (list anything-c-source-man-pages
            anything-c-source-info-cl
            anything-c-source-info-pages
            anything-c-source-info-elisp
            anything-c-source-apropos-emacs-commands
            anything-c-source-apropos-emacs-functions
            anything-c-source-apropos-emacs-variables))
  ;; anything-for-document コマンドを作成
  (defun anything-for-document ()
    "Preconfigured `anything' for anything-for-document."
    (interactive)
    (anything anything-for-document-sources (thing-at-point 'symbol) nil nil nil "*anything for document*"))
  ;; Command+d に anything-for-documentを割り当て
  (define-key global-map (kbd "s-d") 'anything-for-document)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Auto Complete Mode 関係
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; auto-complete
;; (require 'auto-complete)
;; (require 'auto-complete-config)
;; ;(add-to-list 'ac-dictionary-directories "/Users/Ichiro/.emacs.d/elisp//ac-dict")
;; (add-to-list 'ac-dictionary-directories (expand-file-name "~/elisp//ac-dict"))
;; (ac-config-default)

;; (global-auto-complete-mode t)
;; (setq ac-auto-start t)





;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Elscreen 関係
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; Elscreen：GNU Screenライクなウィンドウ管理を実現
;; (when (require 'elscreen nil t)
;;   (if window-system
;;       (define-key elscreen-map (kbd "C-z") 'iconify-or-deiconify-frame)
;;     (define-key elscreen-map (kbd "C-z") 'suspend-emacs)))

;; (require 'elscreen-speedbar)

;; (require 'elscreen-server)

;; (require 'elscreen-dnd)

;; ;; 以下は自動でスクリーンを生成する場合の設定
;; (defmacro elscreen-create-automatically (ad-do-it)
;;   `(if (not (elscreen-one-screen-p))
;;        ,ad-do-it
;;      (elscreen-create)
;;      (elscreen-notify-screen-modification 'force-immediately)
;;      (elscreen-message "New screen is automatically created")))

;; (defadvice elscreen-next (around elscreen-create-automatically activate)
;;   (elscreen-create-automatically ad-do-it))

;; (defadvice elscreen-previous (around elscreen-create-automatically activate)
;;   (elscreen-create-automatically ad-do-it))

;; (defadvice elscreen-toggle (around elscreen-create-automatically activate)
;;   (elscreen-create-automatically ad-do-it))





;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; 拡張機能関係
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; redo+: Emacsにredoコマンドを与える
;; ;; (install-elisp "http://www.emacswiki.org/emacs/download/redo+.el")
;; (when (require 'redo+ nil t)
;;   (define-key global-map (kbd "M-s-Ω") 'redo)) ; redo を割り当てる

;; ;; undohist：閉じたバッファも Undo できる
;; ;; (install-elisp "http://cx4a.org/pub/undohist.el")
;; (when (require 'undohist nil t)
;;   (undohist-initialize))

;; ;; undo-tree：Undo の分岐を視覚化する
;; ;; (install-elisp "http://www.dr-qubit.org/undo-tree/undo-tree.el")
;; (when (require 'undo-tree nil t)
;;   (global-undo-tree-mode))

;; ;; point-undo：カーソル位置を Undo
;; ;; (install-elisp "http://www.emacswiki.org/cgi-bin/wiki/download/point-undo.el")
;; (when (require 'point-undo nil t)
;;   (define-key global-map (kbd "M-[") 'point-undo)
;;   (define-key global-map (kbd "M-]") 'point-redo))

;; ;; wdiree：dired で直接ファイルをリネーム
;; (require 'wdired)
;; (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; ;;; smartchr：サイクルスニペット
;; ;; (install-elisp "https://raw.github.com/imakado/emacs-smartchr/master/smartchr.el")
;; ;; (when (require 'smartchr nil t)
;; ;;   (define-key global-map (kbd "=") (smartchr '("=" " = " " == " " === ")))
;; ;;   (defun css-mode-hooks ()
;; ;;     (define-key cssm-mode-map (kbd ":") (smartchr '(": " ":"))))

;; ;;   (add-hook 'css-mode-hook 'css-mode-hooks))

;; ;; Emacsから本格的にシェルを使う
;; ;; (install-elisp "http://www.emacswiki.org/emacs/download/multi-term.el")

;; ;; shell の存在を確認
;; (defun skt:shell ()
;;   (or (executable-find "zsh")
;;       (executable-find "bash")
;;       (executable-find "cmdproxy")
;;       (error "can't find 'shell' command in PATH!!")))

;; ;; Shell 名の設定
;; (setq shell-file-name (skt:shell))
;; (setenv "SHELL" shell-file-name)
;; (setq explicit-shell-file-name shell-file-name)

;; ;; Emacs が保持する terminfo を利用する
;; (setq system-uses-terminfo nil)

;; ;; エスケープを綺麗に表示する
;; (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; (when (require 'multi-term nil t)
;;   (setq multi-term-program shell-file-name))
;; (add-hook 'term-mode-hook '(lambda ()
;;                  (define-key term-raw-map "\C-y" 'term-paste)
;;                  (define-key term-raw-map "\C-q" 'move-beginning-of-line)
;;                  (define-key term-raw-map "\C-f" 'forward-char)
;;                  (define-key term-raw-map "\C-b" 'backward-char)
;;                  (define-key term-raw-map "\C-t" 'set-mark-command)
;;                  (define-key term-raw-map (kbd "ESC") 'term-send-raw)
;;                  (define-key term-raw-map [delete] 'term-send-raw)
;;                              (define-key term-raw-map "\C-z"
;;                                (lookup-key (current-global-map) "\C-z"))))
;; (global-set-key (kbd "C-c n") 'multi-term-next)
;; (global-set-key (kbd "C-c p") 'multi-term-prev)
;; (set-language-environment  'utf-8)
;; (prefer-coding-system 'utf-8)
;; ;; multi-term 呼び出しキーの割り当て
;; (global-set-key (kbd "C-c t") '(lambda ()
;;                                 (interactive)
;;                                 (term shell-file-name)))
;; (add-to-list 'term-unbind-key-list '"M-x")

;; (require 'ucs-normalize)
;; (setq file-name-coding-system 'utf-8-hfs)
;; (setq locale-coding-system 'utf-8-hfs)
;; (setq system-uses-terminfo nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Web開発 関係
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; HTML/JS/PHPなどのコードを同時に補正
;; (load "nxhtml/autostart.el")

;; mmm-mode で JS と HTML
;; autoload
(autoload 'javascript-mode "javascript" "JavaScript mode" t)

;; mmm-mode
(require 'mmm-mode)
(setq mmm-global-mode 'maybe)
(setq mmm-submode-decoration-level 2)
(set-face-background 'mmm-default-submode-face "gray15")

;; js in html
(mmm-add-classes
 '((js-in-html
    :submode javascript-mode
    :front "<script[^>]*>\n<!--\n"
    :back  "// ?-->\n</script>")))
(mmm-add-mode-ext-class nil "\\.s?html?\\(\\..+\\)?$" 'js-in-html)



;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; PHP 関係
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; php-mode
;; (require 'php-mode)

;; (setq php-mode-force-pear t) ;PEAR規約のインデント設定にする
;; (add-to-list 'auto-mode-alist '("\\.php$" . php-mode)) ;*.phpのファイルのときにphp-modeを自動起動する

;; ;; php-mode-hook
;; (add-hook 'php-mode-hook
;;           (lambda ()
;;             (require 'php-completion)
;;             (php-completion-mode t)
;;             (define-key php-mode-map (kbd "C-o") 'phpcmp-complete) ;php-completionの補完実行キーバインドの設定
;;             (make-local-variable 'ac-sources)
;;             (setq ac-sources '(
;;                                ac-source-words-in-same-mode-buffers
;;                                ac-source-php-completion
;;                                ac-source-filename
;;                                ))))





;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Python 関係
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; python-mode
;; (setq auto-mode-alist
;;       (cons '("\\.py$" . python-mode) auto-mode-alist))
;; (setq interpreter-mode-alist (cons '("python" . python-mode) interpreter-mode-alist))
;; (autoload 'python-mode "python-mode" "Python editing mode." t)

;; ;; python-modeでインデントを４つに
;; ;;python-mode
;; (add-hook 'python-mode-hook
;;       '(lambda()
;;          (setq indent-tabs-mode t)
;;          (setq indent-level 4)
;;          (setq python-indent 4)
;;          (setq tab-width 4)))

;; ;; pysmell
;; ;(require 'pysmell)
;; ;(add-hook 'python-mode-hook (lambda () (pysmell-mode 1)))





;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Ruby 関係
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; ruby-mode
;; (setq load-path (cons (expand-file-name "~/elisp/ruby") load-path))
;; (autoload 'ruby-mode "ruby-mode"
;;   "Mode for editing ruby source files" t)
;; (setq auto-mode-alist
;;       (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
;; (setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
;;                                      interpreter-mode-alist))
;; (autoload 'run-ruby "inf-ruby"
;;   "Run an inferior Ruby process")
;; (autoload 'inf-ruby-keys "inf-ruby"
;;   "Set local key defs for inf-ruby in ruby-mode")
;; (add-hook 'ruby-mode-hook
;;           '(lambda () (inf-ruby-keys)))

;; ;; ruby-electric
;; (require 'ruby-electric)
;; (add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

;; ;; rubydb
;; (autoload 'rubydb "rubydb3x"
;;   "run rubydb on program file in buffer *gud-file*.
;; the directory containing file becomes the initial working directory
;; and source-file directory for your debugger." t)

;; ;; rails
;; (setq load-path (cons (expand-file-name "~/elisp/emacs-rails") load-path))
;; (defun try-complete-abbrev (old)
;;   (if (expand-abbrev) t nil))
;; (setq hippie-expand-try-functions-list
;;       '(try-complete-abbrev
;;         try-complete-file-name
;;         try-expand-dabbrev))
;; (setq rails-use-mongrel t)
;; ;(require 'cl)
;; (require 'rails)

;; ;; ruby-block
;; (require 'ruby-block)
;; (ruby-block-mode t)
;; ;; ミニバッファに表示し, かつ, オーバレイする.
;; (setq ruby-block-highlight-toggle t)

;; ;; ECB
;; ;; (setq load-path (cons (expand-file-name "~/elisp/ecb-2.40") load-path))
;; ;; (load-file "~/elisp/cedet-1.0pre3/common/cedet.el")
;; ;; (setq semantic-load-turn-useful-things-on t)
;; ;; (require 'ecb)
;; ;; (setq ecb-tip-of-the-day nil)
;; ;; (setq ecb-windows-width 0.25)
;; ;; (defun ecb-toggle ()
;; ;;   (interactive)
;; ;;   (if ecb-minor-mode
;; ;;       (ecb-deactivate)
;; ;;     (ecb-activate)))
;; ;; (global-set-key [f2] 'ecb-toggle)

;; ;; rsense
;; (setq rsense-home (expand-file-name "~/.emacs.d/elisp/rsense-0.3"))
;; (add-to-list 'load-path (concat rsense-home "/etc"))
;; (require 'rsense)
;; (add-hook 'ruby-mode-hook
;;           '(lambda ()
;;              ;; .や::を入力直後から補完開始
;;              (add-to-list 'ac-sources 'ac-source-rsense-method)
;;              (add-to-list 'ac-sources 'ac-source-rsense-constant)
;;              ;; C-x .で補完出来るようキーを設定
;;              (define-key ruby-mode-map (kbd "C-x .") 'ac-complete-rsense)))

;; ;; ruby reference
;; (setq rsense-rurema-home (concat rsense-home "/doc/ruby-refm-1.9.2"))
;; (setq rsense-rurema-refe "refe-1_9_2")





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Perl 関係
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; cperl-mode
(defalias 'perl-mode 'cperl-mode)

;; インデントを空白4つに
(add-hook 'cperl-mode-hook
          '(lambda ()
			 (cperl-set-style "PerlStyle")))

;; ;; perl-completion
;; (add-hook 'cperl-mode-hook
;;           (lambda()
;;             (require 'perl-completion)
;;             (perl-completion-mode t)))

;; (add-hook  'cperl-mode-hook
;;            (lambda ()
;;              (when (require 'auto-complete nil t) ; no error whatever auto-complete.el is not installed.
;;                (auto-complete-mode t)
;;                (make-variable-buffer-local 'ac-sources)
;;                (setq ac-sources
;;                      '(ac-source-perl-completion)))))





;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; TeX 関係
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; yatex
;; (setq auto-mode-alist
;;       (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
;; (autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;; (setq tex-command "platex"
;;       dvi2-command "dviout -1 -Set=!m"
;;       YaTeX-kanji-code 4 ;
;;       YaTeX-latex-message-code 'utf-8
;;       section-name "documentclass"
;;       makeindex-command "mendex"
;;       YaTeX-use-AMS-LaTeX t
;;       YaTeX-use-LaTeX2e t
;;       YaTeX-use-font-lock t
;;       )
;; (add-hook 'yatex-mode-hook'
;;   (lambda ()(setq auto-fill-function nil)))

;; ;; previewにtexshop
;; (setq tex-command "~/Library/TeXShop/bin/platex2pdf-utf8"
;;   dvi2-command "open -a TeXShop")





;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; yasnippet 関連
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'yasnippet)

;; ;; メニューは使わない
;; (setq yas/use-menu nil)

;; ;; トリガはSPC, 次の候補への移動はTAB
;; (setq yas/trigger-key (kbd "SPC"))
;; (setq yas/next-field-key (kbd "TAB"))

;; ;;; [2008-03-20]
;; ;;; ポップアップをdropdown-listにする

;; ;; ver 0.4.0からyasnippel.el内にdropdown-list.elが含まれるようになった
;; ;; が、いまのところ、それだとリストの選択肢でC-mしてもinsertされない。
;; ;; 理由はわからないが、とりあえず自前で用意したものをrequireするとうま
;; ;; く行く。

;; (require 'dropdown-list)
;; (setq yas/text-popup-function
;;       #'yas/dropdown-list-popup-for-template)

;; ;;; [2008-03-20]
;; ;;; コメントやリテラルではスニペットを展開しない

;; ;; ver 0.4.0からそれを利用して、コメント・リテラルの中では、スニペット
;; ;; で特に指定されない限り、展開を行わない。

;; (setq yas/buffer-local-condition
;;       '(or (not (or (string= "font-lock-comment-face"
;;                              (get-char-property (point) 'face))
;;                     (string= "font-lock-string-face"
;;                              (get-char-property (point) 'face))))
;;            '(require-snippet-condition . force-in-comment)))

;; ;;; [2008-03-15]
;; ;;; 複数のディレクトリからスニペットを読み込む。

;; ;; yasnippetのsnippetを置いてあるディレクトリ
;; ;; (setq yas/root-directory (expand-file-name "~/dev/yasnippet/snippets"))
;; (setq yas/root-directory (expand-file-name "~/.emacs.d/elisp/snippets"))

;; ;; 自分用スニペットディレクトリ(リストで複数指定可)
;; (defvar my-snippet-directories
;;   (list ;; (expand-file-name "~/.emacs.d/elisp/yasnippet-snippets/common")  ; CodeRepos
;;         ;; (expand-file-name "~/.emacs.d/elisp/yasnippet-snippets/ichiro") ; CodeRepos
;;         (expand-file-name "~/.emacs.d/elisp/snippets")))            ; Private

;; ;; yasnippet公式提供のものと、自分用カスタマイズスニペットをロード同名
;; ;; のスニペットが複数ある場合、あとから読みこんだ自分用のものが優先され
;; ;; る。また、スニペットを変更、追加した場合、このコマンドを実行すること
;; ;; で、変更・追加が反映される。

;; (defun yas/load-all-directories ()
;;   (interactive)
;;   (yas/reload-all)
;;   (mapc 'yas/load-directory-1 my-snippet-directories))

;; ;;; [2008-03-17]
;; ;;; yasnippet展開中はflymakeを無効にする

;; (defvar flymake-is-active-flag nil)

;; (defadvice yas/expand-snippet
;;   (before inhibit-flymake-syntax-checking-while-expanding-snippet activate)
;;   (setq flymake-is-active-flag
;;         (or flymake-is-active-flag
;;             (assoc-default 'flymake-mode (buffer-local-variables))))
;;   (when flymake-is-active-flag
;;     (flymake-mode-off)))

;; (add-hook 'yas/after-exit-snippet-hook
;;           '(lambda ()
;;              (when flymake-is-active-flag
;;                (flymake-mode-on)
;;                (setq flymake-is-active-flag nil))))

;; ;;; [2008-03-19]
;; ;;; yasnippetを使って、ttのディレクティヴを補完

;; ;; スニペットに`(tt-directives)`と書いて置くと補完読み込みする。
;; ;; http://clouder.jp/yoshiki/mt/archives/000377.html から。

;; ;; TODO: minor-modeでフェイスを定義して、色をつけたい。
;; (defvar tt-directives
;;   '(
;;     ("IF")
;;     ("UNLESS")
;;     ("ELSIF")
;;     ("ELSE")
;;     ("FOREACH")
;;     ("WHILE")
;;     ("FILTER")
;;     ("GET")
;;     ("CALL")
;;     ("MACRO")
;;     ("SET")
;;     ("DEFAULT")
;;     ("INSERT")
;;     ("INCLUDE")
;;     ("BLOCK")
;;     ("END")
;;     ("PROCESS")
;;     ("WRAPPER")
;;     ("SWITCH")
;;     ("CASE")
;;     ("USE")
;;     ("PERL")
;;     ("RAWPERL")
;;     ("TRY")
;;     ("THROW")
;;     ("FINAL")
;;     ("CATCH")
;;     ("NEXT")
;;     ("LAST")
;;     ("RETURN")
;;     ("STOP")
;;     ("CLEAR")
;;     ("META")
;;     ("TAGS")
;;     ))

;; (defun tt-insert-directive ()
;;   (let ((directive (completing-read "Directive Name: " tt-directives nil t)))
;;     (when (and directive
;;              (not (string= directive "")))
;;         (concat "[%- " directive " %]"))))

;; ;; yasnippet初期化
;; (yas/initialize)
;; (yas/load-all-directories)





;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; flymake 関係
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (when (require 'flymake nil t)
;;   (global-set-key "\C-cd" 'flymake-display-err-menu-for-current-line)

;;   ;; C設定用
;;   (defun flymake-c-init ()
;;     (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                          'flymake-create-temp-inplace))
;;            (local-file  (file-relative-name
;;                          temp-file
;;                          (file-name-directory buffer-file-name))))
;;       (list "gcc" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))
;;   (push '("\\.c$" flymake-c-init) flymake-allowed-file-name-masks)

;;   (add-hook 'c-mode-hook
;;             '(lambda () (flymake-mode t)))

;;   ;; C++設定用
;;   (defun flymake-cc-init ()
;;     (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                          'flymake-create-temp-inplace))
;;            (local-file  (file-relative-name
;;                          temp-file
;;                          (file-name-directory buffer-file-name))))
;;       (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))
;;   (push '("\\.cc$" flymake-cc-init) flymake-allowed-file-name-masks)
;;   (push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)
;;   (push '("\\.h$" flymake-cc-init) flymake-allowed-file-name-masks)
;;   (push '("\\.hpp$" flymake-cc-init) flymake-allowed-file-name-masks)

;;   (add-hook 'c++-mode-hook
;;             '(lambda () (flymake-mode t)))

;;   ;; PHP用設定
;;   (when (not (fboundp 'flymake-php-init))
;;     ;; flymake-php-initが未定義のバージョンだったら、自分で定義する
;;     (defun flymake-php-init ()
;;       (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                            'flymake-create-temp-inplace))
;;              (local-file  (file-relative-name
;;                            temp-file
;;                            (file-name-directory buffer-file-name))))
;;         (list "php" (list "-f" local-file "-l"))))
;;     (setq flymake-allowed-file-name-masks
;;           (append
;;            flymake-allowed-file-name-masks
;;            '(("\\.php[345]?$" flymake-php-init))))
;;     (setq flymake-err-line-patterns
;;           (cons
;;            '("\\(\\(?:Parse error\\|Fatal error\\|Warning\\): .*\\) in \\(.*\\) on line \\([0-9]+\\)" 2 3 nil 1)
;;            flymake-err-line-patterns)))

;;   (add-hook 'php-mode-hook
;;             '(lambda() (flymake-mode t)))

;;   ;; JavaScript用設定
;;   (when (not (fboundp 'flymake-javascript-init))
;;     ;; flymake-javascript-initが未定義のバージョンだったら、自分で定義する
;;     (defun flymake-javascript-init ()
;;       (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                          'flymake-create-temp-inplace))
;;              (local-file (file-relative-name
;;                           temp-file
;;                           (file-name-directory buffer-file-name))))
;;         ;;(list "js" (list "-s" local-file))
;;         (list "jsl" (list "-process" local-file))
;;         ))
;;     (setq flymake-allowed-file-name-masks
;;           (append
;;            flymake-allowed-file-name-masks
;;            '(("\\.json$" flymake-javascript-init)
;;              ("\\.js$" flymake-javascript-init))))
;;     (setq flymake-err-line-patterns
;;           (cons
;;            '("\\(.+\\)(\\([0-9]+\\)): \\(?:lint \\)?\\(\\(?:warning\\|SyntaxError\\):.+\\)" 1 2 nil 3)
;;            flymake-err-line-patterns)))

;;   (add-hook 'javascript-mode-hook
;;             '(lambda() (flymake-mode t))))

;; ;; ruby用設定
;; (defun flymake-ruby-init ()
;;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;          (local-file  (file-relative-name
;;                        temp-file
;;                        (file-name-directory buffer-file-name))))
;;     (list "ruby" (list "-c" local-file))))

;; (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
;; (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

;; (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

;; (add-hook 'ruby-mode-hook
;;           '(lambda ()

;;              ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
;;              (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
;;                  (flymake-mode t))
;;              ))


;; ;; perl用設定
;; (require 'set-perl5lib)

;; ;; http://unknownplace.org/memo/2007/12/21#e001
;; (defvar flymake-perl-err-line-patterns
;;   '(("\\(.*\\) at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]" 2 3 nil 1)))

;; (defconst flymake-allowed-perl-file-name-masks
;;   '(("\\.pl$" flymake-perl-init)
;;     ("\\.pm$" flymake-perl-init)
;;     ("\\.t$" flymake-perl-init)))

;; (defun flymake-perl-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list "perl" (list "-wc" local-file))))

;; (defun flymake-perl-load ()
;;   (interactive)
;;   (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
;;     (setq flymake-check-was-interrupted t))
;;   (ad-activate 'flymake-post-syntax-check)
;;   (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-perl-file-name-masks))
;;   (setq flymake-err-line-patterns flymake-perl-err-line-patterns)
;;   (set-perl5lib)
;;   (flymake-mode t))

;; (add-hook 'cperl-mode-hook 'flymake-perl-load)


;; (global-set-key "\C-cd" 'flymake-display-err-menu-for-current-line)
;; (global-set-key "\C-cn" 'flymake-goto-next-error)
;; (global-set-key "\C-cp" 'flymake-goto-prev-error)





;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; font 関連
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; font1x  leim-list.el をロードしたりすると元の japanese-iso-8bit (EUC-JP) に戻されてしまうので、 .emacs の最後のほうに入れるのが無難
;; (setq my-font "-*-*-medium-r-normal--12-*-*-*-*-*-fontset-Inconsolata")
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'japanese-jisx0208
;;                   '("Takaoゴシック" . "unicode-bmp")
;; )

;; (set-language-environment "Japanese")
;; (prefer-coding-system 'utf-8-unix)
;; (set-default-coding-systems 'utf-8-unix)
;; ;; for MacOSX
;; (require 'ucs-normalize)
;; (setq file-name-coding-system 'utf-8-hfs)
;; (setq locale-coding-system 'utf-8-hfs)
;; ;; Windows
;; ;; (setq file-name-coding-system 'sjis)
;; ;; (setq locale-coding-system 'utf-8)
;; ;; Linux, etc
;; ;; (setq file-name-coding-system 'utf-8)
;; ;; (setq locale-coding-system 'utf-8)

;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-buffer-file-coding-system 'utf-8)
;; (setq default-buffer-file-coding-system 'utf-8)

;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(safe-local-variable-values (quote ((TeX-master . t)))))
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  )

;;;; tree-undo
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))