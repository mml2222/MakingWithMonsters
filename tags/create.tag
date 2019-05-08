<create>
  <!-- HTML -->
  <button class="btn btn-success my-2 my-sm-0 offset-md-3" data-toggle="modal" data-target="#startNewProject" onclick={ startNewProject }>Start New Project</button>

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
    var curProjectId;

    startNewProject(){
      showDialog = true;
      this.update();
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

          // trigger to pass curProjectId

          observer.trigger('project:created', curProjectId.id, this.inputProjectTitle);

          showDialog = false;
          this.refs.projectTitle.value = '';
          this.showProjectTitle = true;
        }
        else{
          throw new Error('User is not signed in - should not see create tag');
        }
      }
    }

    </script>


</create>
