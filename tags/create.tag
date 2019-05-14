<create>
  <!-- HTML -->
  <!-- button for first time using the app -->
  <div show={ firstProject }>
    <button class="btn btn-success my-2 my-sm-0 offset-md-3" data-toggle="modal" data-target="#startNewProject" onclick={ firstProject }>Start a Project</button>
  </div>
  <!-- button to start a new project -->
  <div show={ newProject }>
    <!-- <button class="btn btn-success my-2 my-sm-0 offset-md-3" data-toggle="modal" data-target="#startNewProject" onclick={ startNewProject }>Start New Project</button> -->
    <button class="btn btn-success my-2 my-sm-0 offset-md-3" data-toggle="modal" data-target="#finalReflection" show={ showStartNewProject } onclick={ startNewProject }>Start New Project</button>
    <div show={ showFinalReflection }>
      <finalReflection></finalReflection>
    </div>
  </div>
  <!-- modal for start project -->
  <div id="startNewProject" class="modal" data-backdrop="false" role="dialog" aria-hidden="true" show={ showDialog }>
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-body">
          <h1>What are you making today?</h1>
          <input type="text" ref="projectTitle"></input>
          <br>
        </div>
        <!-- add monster moments -->
        <div class="modal-footer">
          <button class="btn btn-success" data-toggle="modal" data-target="#PredictMonsters" onclick={ getStarted }>Get Started</button>
          <button class="btn btn-danger" data-dismiss="modal" onclick={closeDialog}>Cancel</button>
        </div>
      </div>
    </div>

  </div>
  <script>
    this.inputProjectTitle = null
    this.showProjectTitle = false
    this.db = firebase.firestore();
    this.projectCollection;
    this.firstProject = false;
    this.newProject = false;
    this.showStartNewProject = true;
    this.showFinalReflection = false;
    var curProjectId;

    firstProject(){
      showDialog = true;
    }
    startNewProject(){
      showDialog = true;
      this.showStartNewProject = false;
      this.showFinalReflection = true;
    }
    closeDialog(){
      showDialog = false;
      this.update();
    }

    getStarted(){
      this.inputProjectTitle = this.refs.projectTitle.value
      if(this.inputProjectTitle == ""){
        alert("Don't forget to answer the question 'What are you making today?'")
      }
      else {
        var userId = firebase.auth().currentUser.uid;
        if(userId != null) {
          var userProjectCollection = this.db.doc('Users/' + userId).collection('Projects');
          if(!userProjectCollection){
            throw new Error('Error creating userProjectCollection');
          }
          curProjectId = userProjectCollection.doc();

          var projectData = {
            projectName : this.inputProjectTitle,
            projectId: curProjectId.id
          };
          curProjectId.set(projectData);
          // update current project to Users collection id document
          // let refCurProjectId = this.db.doc('Users/' + userId);
          // refCurProjectId.update({curProjectId: curProjectId.id});
          this.db.doc('Users/' + userId).update({curProjectId: curProjectId.id});
          // trigger to pass curProjectId
          observer.trigger('project:created', curProjectId.id, this.inputProjectTitle);
          showDialog = false;
          this.refs.projectTitle.value = '';
          this.showProjectTitle = true;
          this.newProject = true;
          this.firstProject = false
        }
        else{
          throw new Error('User is not signed in - should not see create tag');
        }
      }
    }
    //
    observer.on('project:firstProject', (firstProject) => {
      this.firstProject = true;
      this.newProject = false;
      this.update();
    });

    observer.on('project:newProject', (newProject) => {
      this.newProject = true;
      this.firstProject = false
      this.update();
    });
    </script>


</create>
