<home>
  <!-- HTML -->
  <!-- first time using the app -->
  <div show={ !newProject }>
      <create></create>
  </div>

  <!-- mount new project when existing -->
  <div show={ !newProject }>
    <createExisting></createExisting>
  </div>

  <button class="btn btn-outline-danger my-2 my-sm-0 offset-md-3" type="button"
    show={showAskMonster} onclick={ askMonster }>Ask a Monster for Help</button>

  <div show={ mode == 2 }>
    <div show={ showProjectTitle }>
      <h1> My Project: {inputProjectTitle} </h1>
      <!-- todo: add path image -->
    </div>
    <finalReflection></finalReflection>
    <div show={ showPickMonsters }>
      <pickMonster></pickMonster>
    </div>
  </div>

  <script>
    this.showAskMonster = false;
    this.showPickMonsters = false;

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
    // receives mode
    observer.on('project:mode', (mode) => {
      console.log("what has been passed " + mode);
      this.mode = mode;
      console.log("in trigger " + this.mode);
      this.update();
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
</home>
