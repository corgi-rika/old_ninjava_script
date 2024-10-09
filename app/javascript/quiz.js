document.addEventListener('turbo:load', function() {
  const quizButtons = document.querySelectorAll('.quiz-button');
  const quizModal = document.getElementById('quiz-modal');
  const quizModalMessage = document.getElementById('quiz-modal-message');
  const quizModalIcon = document.getElementById('quiz-modal-icon'); // SVGアイコンの要素を取得
  const correctSound = document.getElementById('correct-sound');
  const incorrectSound = document.getElementById('incorrect-sound');

  quizButtons.forEach(button => {
    let clicked = false;  // クリックされたかどうかを確認するフラグ

    button.addEventListener('click', function(event) {
      if (!clicked) {  // まだクリックされていない場合のみ処理を行う
        clicked = true;
        event.preventDefault(); // デフォルトのリンク動作を防ぐ
        const userAnswer = button.dataset.answer;
        const correctAnswer = button.dataset.correct;
        const url = button.dataset.url;

        // モーダルのクラスをリセット
        quizModal.classList.remove('correct', 'incorrect');
        quizModalIcon.classList.remove('correct', 'incorrect');  // アイコンのクラスもリセット
        quizModalIcon.style.display = 'none'; // アイコンを非表示にリセット

        if (userAnswer === correctAnswer) {
          quizModalMessage.textContent = 'すばらしい！正解です！';
          quizModal.classList.add('correct');  // quizModalに正解のクラスを追加
          quizModalIcon.classList.add('correct');  // アイコンの正解用クラスを追加
          correctSound.play(); // 正解時の音声を再生
        } else {
          quizModalMessage.textContent = 'ざんねん！不正解です。';
          quizModal.classList.add('incorrect');  // quizModalに不正解のクラスを追加
          quizModalIcon.classList.add('incorrect');  // アイコンの不正解用クラスを追加
          incorrectSound.play(); // 不正解時の音声を再生
        }

        // アイコンを表示
        quizModalIcon.style.display = 'block';

        // モーダルを表示
        quizModal.style.display = 'block';
        // 1秒の遅延後に指定されたURLに遷移
        setTimeout(() => {
          window.location.href = url; // データ属性からURLを取得
        }, 1000);
      }
    });
  });
});
