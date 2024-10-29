// review_modal *****************************************************************************
function review_modal() {
  const modal = document.getElementById("review_modal")
  const openBtn = document.getElementById("review_open_button")
  const closeBtn = document.querySelector(".modal_close_btn")
  const ratingScore = document.getElementById("rating_score")
  const slider = document.getElementById("rating_slider")
  const form = document.getElementById("review_form")

  if (!openBtn) return null

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
      console.log("クリック検知")
      modal.style.display = "none"
    }
  })

  // フォーム送信時にモーダルを閉じる
  form.addEventListener("submit", () => {
    modal.style.display = "none"
  })
}


window.addEventListener("turbo:load", review_modal)

// review_star *******************************************************************************************
function review_star() {
  const starRating = document.querySelector(".worksShow_reviewsIndex_review_star_box")
  const rating = parseFloat(starRating.getAttribute("data-rating"))
  const stars = starRating.querySelectorAll(".worksShow_reviewsIndex_review_star")
  
  stars.forEach((star, index) => {
    if (index < Math.floor(rating)) {
      star.classList.add("active")
    } else if (index < rating) {
      star.style.color = `rgba(255, 215, 0, ${rating - index})`
    }
  })
}

window.addEventListener("turbo:load", review_star)