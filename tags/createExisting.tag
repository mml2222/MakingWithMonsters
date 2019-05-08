<createexisting>
  <!-- HTML -->
  <button class="btn btn-success" data-toggle="modal" data-target="#startNewProject">Start New Project</button>

  <div id="startNewProject" class="modal" data-backdrop="false" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-body">
          <h1>How are you feeling?</h1>
          <div class="row justify-content-center">
            <form method="get">
              <div class="form-group">
                <div class="col-md-2 form-check" each={ emotionItem, i in myEmotions}>
                  <label class="btn btn-info">
                    <img src={ emotionItem.img } class="img-thumbnail img-check  { check: emotionItem.pick }" onclick={ parent.toggle }>
                    <input type="radio" name={ emotionItem.id } id={ emotionItem.id } class="hidden">
                  </label>
                </div>
              </div>
            </form>
          </div>
          <br>
          <div class="">
            <h1>Which monster moment was the most helpful?</h1>
              <!-- add monsters they used -->
          </div>
        </div>
        <!-- add monster moments -->
        <div class="modal-footer">
          <button class="btn btn-success" onclick={ getStarted }>Get Started</button>
          <button class="btn btn-danger" data-dismiss="modal">Cancel</button>
        </div>
      </div>
    </div>

  </div>
  <script>
    // JAVASCRIPT
    let that = this;
    let database = firebase.firestore()
    let emotionsRef = database.collection('Emotions');
    this.myEmotions = [];
    //emotion reference in database
    let refPickedEmotion;

    startNewProject() {
      showDialog = true
    }
    closeDialog() {
      e.preventDefault()
      showDialog = false
    }

    // getStarted(e){   e.preventDefault()   this.inputProjectTitle = this.refs.projectTitle.value   if(this.inputProjectTitle == ""){     alert("Don't forget to answer the question 'What are you making today?'")   }   else {     var userId =
    // firebase.auth().currentUser.uid;     if(userId != null) {       var userProjectCollection = this.db.doc('Users/' + userId).collection('Projects');       if(!userProjectCollection){         throw new Error('Error creating userProjectCollection'); }
    // curProjectId = userProjectCollection.doc();
    //
    //       var projectData = {         projectName : this.inputProjectTitle,         projectId: curProjectId.id       };       curProjectId.set(projectData);       console.log(curProjectId.id);
    //
    //       showDialog = false;       this.refs.projectTitle.value = '';       this.showProjectTitle = true;       this.showPickMonsters = true;
    //
    //     }     else{       throw new Error('User is not signed in - should not see create tag');     }   } } read emotion assets from database
    emotionsRef.onSnapshot(function (snapshot) {
      var emotions = [];
      snapshot.forEach(function (doc) {
        emotions.push(doc.data());
      })
      that.myEmotions = emotions;
      that.update();
    });

    // receives projectId
    observer.on('project:created', (curProject) => {
      this.projectId = curProject;

      this.update();
    });

    //pick emotions
    toggle(event) {
      let userId = firebase.auth().currentUser.uid;
      refPickedEmotion = database.doc('Users/' + userId).collection('Projects');
      let pickedEmotion = event.item.emotionItem.id;
      console.log(pickedEmotion);
      if (event.item.emotionItem.pick === false) {
        event.item.emotionItem.pick = true;
        //update database

        refPickedEmotion.doc(this.projectId).update({emotion: pickedEmotion});
      }
    }
    //for Modal
    $('#myModal').on('shown.bs.modal', function () {
      $('#myInput').trigger('focus')
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
</createexisting>
