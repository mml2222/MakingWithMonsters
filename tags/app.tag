<app>
  <!-- HTML -->
  <login></login>


  <script>
    // JAVASCRIPT
    let tag = this;
    this.mode = 0;

    // need for login
    firebase.auth().onAuthStateChanged(userObj => {
      if (userObj) {
        this.user = userObj;
      } else {
        this.user = null;
      }
      this.update();
      console.log(this.mode);
      // trigger to pass mode
      observer.trigger('project:mode', this.mode);
    });




  </script>

  <style>
    /* CSS */
    :scope {}
    .special {
      background-color: #333333;
      color: #FFFFFF;
    }
  </style>
</app>
