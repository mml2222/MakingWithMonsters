<pickMonster>
  <!-- HTML -->
  <button class="btn btn-outline-danger my-2 my-sm-0 offset-md-3" type="button" onclick={ showPickDialog }>Pick Monster</button>
  <div show={ showDialog } style="position: fixed; top: 0; right: 0; bottom: 0; left: 0; z-index: 99999999; background-color: rgba(0,0,0,.2);">
    <form style="width: 500px; margin: 200px auto; background-color: white ">
      <h1>Choose the monster you want to work with:</h1>
      <br>
      <div each="{ monster in monsters }">
        <input type="checkbox" id="imageCheckbox" ref="monsterSelected"
          value={monster.id}> <img src={monster.imgUrl}/>
        </input>
      </div>
      <button onclick={pickMonster}>Next</button>
      <button onclick={closeDialog}>Cancel</button>
    </form>
  </div>
  <div show={showProjectTitle}>
    <h1> My Project: {inputProjectTitle} </h1>
  </div>

  <script>
    this.showDialog = false

    async function getMonsters() {
      var monsters = [];
      try{
        var dbMonsters = firebase.firestore().collection('Monsters');
        var dbMonstersArray = await dbMonsters.get();

        dbMonstersArray.forEach(doc => {
          var docData = doc.data();
          var monster = {
            "id":docData.id,
            "imgUrl":docData.img,
            "name":docData.name
          }
          monsters.push(monster);
        });
      }
      catch(err){
        throw new Error(err);
      }
      return monsters;
    };

    showPickDialog(){
      getMonsters().then((monsters) => {
        this.monsters = monsters;
        this.showDialog = true;
        this.update();
      })
      .catch((error) => {
        throw new Error(error.message)
      });
    }
    closeDialog(){
      e.preventDefault()
      showDialog = false
    }

    getStarted(e){
      e.preventDefault()
      this.inputMonster = this.refs.monsterSelected.value

      if(!this.refs.monsterSelected){
        alert("Don't forget to select a monster to help you!")
      }
      else {
        var userId = firebase.auth().currentUser.uid;
        if(userId != null) {
          var userProjectCollection = this.db.doc('Users/' + userId).collection('Projects');
          if(!userProjectCollection){
            throw new Error('Error creating userProjectCollection');
          }
          var projectData = {
            Project_Name : this.inputProjectTitle,
          };
          userProjectCollection.add(projectData);

          this.showDialog = false;
          this.refs.projectTitle.value = '';
          this.showProjectTitle = true;
        }
        else{
          throw new Error('User is not signed in - should not see create tag');
        }
      }
    }
    </script>


</pickMonster>
