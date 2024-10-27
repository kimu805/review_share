function review_modal() {
  const modal = document.getElementById("review_modal")
  const openBtn = document.getElementById("review_open_button")
  const closeBtn = document.querySelector(".modal_close_btn")
  const ratingScore = document.getElementById("rating_score")
  const slider = document.getElementById("rating_slider")
  const form = document.getElementById("review_form")

  console.log(openBtn)

  // モーダルを開く
  openBtn.addEventListener("click", () => {
    modal.style.display = "block"
  })

  // モーダルを閉じる
  closeBtn.addEventListener("click", () => {
    modal.style.display = "none"
  })

  // スライダーの値をリアルタイムで表示
  slider.addEventListener("input", () => {
    ratingScore.textContent = slider.value
  })

  // モーダル外クリックで閉じる
  window.addEventListener("click", (event) => {
    if (event.target == modal) {
      modal.style.display = "none"
    }
  })

  // フォーム送信時にモーダルを閉じる
  form.addEventListener("submit", () => {
    modal.style.display = "none"
  })
}


window.addEventListener("turbo:load", review_modal)