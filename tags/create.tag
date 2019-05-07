<create>
  <!-- HTML -->
  <button class="btn btn-outline-danger my-2 my-sm-0 offset-md-3" type="button" onclick={ startNewProject }>Start New Project</button>
  <div show={showDialog} style="position: fixed; top: 0; right: 0; bottom: 0; left: 0; z-index: 99999999; background-color: rgba(0,0,0,.2);">
    <form style="width: 500px; margin: 200px auto; background-color: white ">
      <h1>What are you making today?</h1>
      <input type="text" ref="projectTitle"></input>
      <br>
      <button onclick={getStarted}>Get Started</button>
      <button onclick={closeDialog}>Cancel</button>
    </form>
  </div>

  <script>
    this.inputProjectTitle = null
    this.showProjectTitle = false
    this.db = firebase.firestore();
    var curProjectId;

    startNewProject(){
      showDialog = true
    }
    closeDialog(){
      e.preventDefault()
      showDialog = false
    }

    getStarted(e){
      e.preventDefault()
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
