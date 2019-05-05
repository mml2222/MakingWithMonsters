<home>
  <!-- HTML -->

  <create showAskMonster={ showAskMonster } ></create>
    <button class="btn btn-outline-danger my-2 my-sm-0 offset-md-3" type="button"
      show={showAskMonster} onclick={ askMonster }>Ask a Monster for Help</button>

  <script>
    this.showAskMonster = false;

    // receives projectId
    observer.on('project:inprogress', (curProjectId) => {
      this.showAskMonster = true;
      this.projectId = curProjectId;
      this.update();
    });

    askMonster(){
      this.showAskMonster = false;
      observer.trigger('project:askMonster', this.projectId);
    };

  </script>

  <style>
    /* CSS */
    :scope {}
    .special {
      background-color: #333333;
      color: #FFFFFF;
    }
  </style>
</home>
