export default {
  props: ["xl", "md", "sm", "xs"],
  methods: {
    // ******************************
    // レスポンシブに高さを設定するメソッド
    // ******************************
    responsiveHeight() {
      let width = window.innerWidth;
      if (width > 1264) {
        this.height = this.xl;
      } else if (width < 1263 && width > 960) {
        this.height = this.md;
      } else if (width < 959 && width > 600) {
        this.height = this.sm;
      } else {
        this.height = this.xs;
      }
    }
  },
  mounted() {
    // 高さの設定を初期化
    this.responsiveHeight();
    // 画面サイズ変更時に高さを設定
    addEventListener("resize", this.responsiveHeight);
  }
};
