<home>
  <!-- HTML -->
  <create></create>
  <button class="btn btn-outline-danger my-2 my-sm-0 offset-md-3" type="button" show={ showAskMonster } onclick={ askMonster }>Ask a Monster for Help</button>

  <div show={showProjectTitle}>
    <h1> My Project: {inputProjectTitle} </h1>
    <img src="assets/images/map/map.png">
  </div>
   <div show={ showPickMonsters }>
     <pickMonster></pickMonster>
   </div>

  <script>
    this.showAskMonster = false;
    this.showPickMonsters = false;
    this.inputProjectTitle;
    this.firstProject = false;
    this.newProject = false;
    this.db = firebase.firestore();

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
      this.showProjectTitle = true;
      this.update();
    });

    observer.on('project:newProject', (newProject) => {
      this.newProject = true;
      this.firstProject = false;
      this.showAskMonster = true;
//      this.showProjectTitle = true;

      refCurProject= this.db.doc('Users/' + firebase.auth().currentUser.uid);
      refUserProject = this.db.doc('Users/' + firebase.auth().currentUser.uid).collection('Projects');
      refCurProject.onSnapshot(function (doc) {
        let projectId = doc.data().curProjectId;
        this.inputProjectTitle = doc.data().curProjectName;
      });
      this.update();
  });
    console.log();
    askMonster() {
      this.showPickMonsters = true;
      this.showAskMonster = true;
      observer.trigger('project:askMonster', this.projectId);
    }
    //todo read project title
    // refCurProjectId= this.db.doc('Users/' + firebase.auth().currentUser.uid);
    // refUserProject = this.db.doc('Users/' + firebase.auth().currentUser.uid).collection('Projects');
    //
    // refCurProjectId.get().then(function(doc) {
    //   let projectId = doc.data().curProjectId;
    //   console.log(projectId);
    //   refCurProjectTitle = refUserProject.doc(projectId);
    //   refCurProjectTitle.get().then(function(doc) {
    //   this.projectName = doc.data().projectName;
    //   console.log(this.projectName);
    //   });
    // });
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
