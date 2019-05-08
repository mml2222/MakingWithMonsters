<home>
  <!-- HTML -->
  <create></create>

  <button class="btn btn-outline-danger my-2 my-sm-0 offset-md-3" type="button"
    show={showAskMonster} onclick={ askMonster }>Ask a Monster for Help</button>
    <div show={ showProjectTitle }>
      <h1> My Project: {inputProjectTitle} </h1>
      <!-- todo: add path image -->
    </div>
    <div show={showFinalReflection}>
      <finalReflection></finalReflection>
    </div>
    <div show={showPickMonsters}>
      <pickMonster></pickMonster>
    </div>

  <script>
    this.showAskMonster = false;
    this.showPickMonsters = false;
    this.showFinalReflection = false;

    observer.on('project:created', (curProject, inputProjectTitle) => {
      this.showPickMonsters = true;
      this.showProjectTitle = true;
      this.inputProjectTitle = inputProjectTitle;
      this.projectId = curProject;
      this.update();
    });

    // receives projectId
    observer.on('project:inprogress', (curProjectId) => {
      this.showPickMonsters = false;
      this.showAskMonster = true;
      this.projectId = curProjectId;
      this.update();
    });

    askMonster(){
      this.showPickMonsters = true;
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
