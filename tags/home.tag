<home>
  <!-- HTML -->
  <!-- <create></create> <button class="btn btn-outline-danger my-2 my-sm-0 offset-md-3" type="button" show={showAskMonster} onclick={ askMonster }>Ask a Monster for Help</button> <div show={showProjectTitle}> <h1> My Project: {inputProjectTitle} </h1>
  </div> <div show={ showPickMonsters }> <pickMonster></pickMonster> </div> -->
  <!-- 1st time using the app -->
  <div show={ mode == 0 }>
    <create></create>
  </div>
  <div show={ mode == 1 }>
    <pickMonster></pickMonster>
  </div>
  <!-- main homepage -->
  <div show={ mode == 2 }>
    <div show={ showProjectTitle }>
      <h1> My Project: {inputProjectTitle} </h1>
      <!-- todo: add path image -->
    </div>
    <finalReflection></finalReflection>
    <pickMonster></pickMonster>
  </div>
  <!-- predict monsters -->
  <!-- <button class="btn btn-info my-2 my-sm-0 offset-md-3" type="button" show={ showAskMonster } onclick={ askMonster }>Ask a Monster for Help</button> </div> -->
  <!-- create new project -->
  <!-- <div show={ mode == 3 }> -->
  <!-- <finalReflection></finalReflection> -->
  <!-- <create></create> -->
  <!-- </div> -->

  <!-- <button class="btn btn-outline-danger my-2 my-sm-0 offset-md-3" type="button" show={showAskMonster} onclick={ askMonster }>Ask a Monster for Help</button>
  <div show={showProjectTitle}>
    <h1>
      My Project: {inputProjectTitle}
    </h1>
  </div>
  <div show={ showPickMonsters }>
    <pickmonster></pickmonster>
  </div> -->

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
    askMonster() {
      this.showPickMonsters = true;
      this.showAskMonster = false;
      observer.trigger('project:askMonster', this.projectId);
    }
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
