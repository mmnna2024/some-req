<!-- Vue.js導入確認用ファイル -->
<template>
  <div class="d-flex flex-column h-100">
    <div class="container mt-5">
      <div class="card mb-4">
        <div class="row g-0">
          <div class="col-md-4">
            <div class="card-body">
              <h3 class="card-title">オンライン注文フォーム</h3>
              <h4>開発言語</h4>
              <ul>
                <li>Vue.js</li>
                <li>Ruby on Rails</li>
              </ul>
              <h4>使用したGem</h4>
              <ul>
                <li>Vue.jsの使用：Webpacker</li>
              </ul>
              <a href='/orders/new' class="btn btn-outline-primary" role="button">オンライン注文フォーム</a>
            </div>
          </div>
          <div class="col-md-8 pt-3 pr-2">
            <div id="formImageCarousel" class="carousel carousel-dark slide">
              <div class="carousel-inner">
                <div class="carousel-item active">
                  <img src="../assets/images/formimage2.png" class="d-block w-100" alt="...">
                </div>
                <div class="carousel-item">
                  <img src="../assets/images/formimage1.png" class="d-block w-100" alt="...">
                </div>
              </div>
              <button class="carousel-control-prev" type="button" data-bs-target="#formImageCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
              </button>
              <button class="carousel-control-next" type="button" data-bs-target="#formImageCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
              </button>
            </div>
          </div>
        </div>
      </div>
      <div class="card mb-4">
        <div class="row g-0">
          <div class="col-md-4">
            <div class="card-body">
              <h3 class="card-title">受注管理一元システム</h3>
              <h4>開発言語</h4>
              <ul>
                <li>Ruby on Rails</li>
              </ul>
              <h4>使用したGem</h4>
              <ul>
                <li>ログイン機能：devise, rexml, devise-i18n</li>
                <li>PDF生成：prawn, prawn-table</li>
                <li>ソート機能・検索機能：ransack</li>
                <li>ページネーション：kaminari</li>
              </ul>
              <a href='admin/sign_in'
              class="btn btn-outline-primary" role="button">受注管理一元システム</a>
              <p class="mt-2">※user名パスワードは職務経歴書に記載</p>
            </div>
          </div>
          <div class="col-md-8 pt-3 pr-2">
            <div id="adminImageCarousel" class="carousel carousel-dark slide">
              <div class="carousel-inner">
                <div class="carousel-item active">
                  <img src="../assets/images/adminimage1.png" class="d-block w-100" alt="...">
                </div>
                <div class="carousel-item">
                  <img src="../assets/images/adminimage2.png" class="d-block w-100" alt="...">
                </div>
              </div>
              <button class="carousel-control-prev" type="button" data-bs-target="#adminImageCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
              </button>
              <button class="carousel-control-next" type="button" data-bs-target="#adminImageCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
              </button>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col">
          <div class="card shadow-sm mb-4" style="max-width: 1040px;">
            <div class="card-body">
              <h4 class="card-title">共通開発環境など</h4>
              <ul>
                <li>スタイル：Bootstrap5</li>
                <li>画像アップロード：image_processing, mini_magick</li>
                <li>セキュリティ対策：dotenv-rails</li>
                <li>AWSデプロイ：unicorn, aws-sdk-s3, capistrano</li>
              </ul>
            </div>
          </div>
        </div>
        <!-- 適当に増やしてください -->
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
  }
}
</script>

<style scoped>
body {
  background-color: #f8f9fa;
}

.container {
  margin-top: 20px;
}

.card {
  border-radius: 10px;
}

.card-body {
  padding: 20px;
}

.card-title {
  margin-bottom: 1rem;
  font-weight: 500;
}

.btn-primary {
  background-color: #007bff;
  border-color: #007bff;
}

.btn-primary:hover {
  background-color: #0056b3;
  border-color: #0056b3;
}

ul {
  padding-left: 1.5rem;
}

ul li {
  margin-bottom: 0.5rem;
}
</style>

