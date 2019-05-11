<home>
  <!-- HTML -->
  <h1>en home</h1>
  <!-- <create></create> <button class="btn btn-outline-danger my-2 my-sm-0 offset-md-3" type="button" show={showAskMonster} onclick={ askMonster }>Ask a Monster for Help</button> <div show={showProjectTitle}> <h1> My Project: {inputProjectTitle} </h1>
  </div> <div show={ showPickMonsters }> <pickMonster></pickMonster> </div> -->
  <!-- 1st time using the app -->
  <!-- <div show={ firstProject }>
    <create></create>
  </div> -->
  <div show={newProject}>
    <create></create>
    <!-- <finalReflection></finalReflection> -->
  </div>
  <!-- <div show={ mode == 1 }>
    <pickMonster></pickMonster>
  </div>
  <!-- main homepage -->
  <!-- <div show={ mode == 2 }>
    <div show={ showProjectTitle }>
      <h1> My Project: {inputProjectTitle} </h1>
    </div>
    <finalReflection></finalReflection>
    <pickMonster></pickMonster>
  </div>  -->

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
    this.inputProjectTitle;
    this.firstProject = false;
    this.newProject = false;

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
    //
    observer.on('project:firstProject', (firstProject) => {
      this.showPickMonsters = true;
      this.showProjectTitle = true;
      this.firstProject = true;
      this.update();
    });

    observer.on('project:newProject', (newProject) => {
      this.showPickMonsters = true;
      this.showProjectTitle = true;
      this.newProject = true;
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
