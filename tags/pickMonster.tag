<pickmonster>
  <!-- the image select check is based of Birjitsinh-->
  <!-- code found in https://bootsnipp.com/snippets/Zl6ql -->
  <!-- HTML -->
<button class="btn btn-success" data-toggle="modal" data-target="#pickMonster">Pick Monster</button>
<div id="pickMonster" class="modal" data-backdrop="false" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-body">
        <h1 class="display-3 text-center">{ mainQuestion }</h1>
        <!-- predict monsters tag is called -->
          <div class="container-fluid">
            <div class="row">
              <!-- <div class="col-md-4"> -->
                <form method="get">
                  <div class="form-group">
                    <div class="col-md-3" each={ monsterItem, i in myMonsters}>
                      <label class="btn btn-info">
                        <img src={ monsterItem.img } alt={ monsterItem.name } class="img-thumbnail img-check { check: monsterItem.pick }" onclick={ parent.toggle }>
                        <input type="checkbox" name={ monsterItem.name } id={ monsterItem.id } class="hidden">
                      </label>
                    </div>
                  </div>
                </form>
              <!-- </div> -->
            </div>
        </div>
      <!-- add monster moments -->
      <div class="modal-footer">
        <button class="btn btn-danger" show={!isNewProject} data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-success" onclick={ selectMonster }>Next</button>
      </div>
    </div>
  </div>

</div>

<script>
  // JAVASCRIPT
  var that = this;
  let database = firebase.firestore()
  var monsterRef = database.collection('Monsters');
  this.myMonsters = [];
  let refSelectedMonsters;
  this.mainQuestion;
  this.isNewProject;

  //read monster assets from database
  monsterRef.onSnapshot(function (snapshot) {
    var monsters = [];
    snapshot.forEach(function (doc) {
      monsters.push(doc.data());
    })
    that.myMonsters = monsters;
    that.update();
  });

  // receives projectId and name
  observer.on('project:created', (curProject) => {
    this.projectId = curProject;
    this.mainQuestion = "What monsters might help you on your journey?";
    this.isNewProject = true;
    this.update();
    //adds to database the possible monsters
    refSelectedMonsters = database.doc('UserMonsters/' + firebase.auth().currentUser.uid).collection('PredictedMonsters');
    refSelectedMonsters.doc(this.projectId).set({//try to make it reading from the database
      askExpert: false,
      changeOneThing: false,
      compareIt: false,
      lookItUp: false,
      playWith:false,
      takeBreak:false,
      talkFriend:false
    });
  });

  // receives projectId, but this time it's from "Ask a Monster"
    observer.on('project:askMonster', (curProject) => {
      this.projectId = curProject;
      this.mainQuestion = "Choose the Monster You Want To Work With:";
      this.isNewProject = false;
      //nothing selected to begin with
      this.myMonsters.forEach(function (monster){
        monster.pick = false;
      });
      this.update();
      //creates new collection MonsterMoments for this Project
      refSelectedMonsters = database.doc('UserMonsters/'+ firebase.auth().currentUser.uid).collection('MonsterMoments');
      if(!refSelectedMonsters){
        throw new Error('Error creating MonsterMoments entry');
      }
    });

    toggle(event) {
      let currentMonster = event.item.monsterItem.id;
      // if they're selecting a monster to help them,
      // they should only be allowed to choose 1
      if(this.isNewProject === false){
        this.myMonsters.forEach(function (monster){
          monster.pick = false;
        });
      }
      if (!event.item.monsterItem.pick || event.item.monsterItem.pick === false) {
        event.item.monsterItem.pick = true;
        //update database: TODO: only update db when they click "Next"
        if(this.isNewProject){
          refSelectedMonsters.doc(this.projectId).update({[currentMonster]: true});
        }
      }
      else {
          event.item.monsterItem.pick = false;
          //update database: TODO: only update db when they click "Next"
          if(this.isNewProject){
            refSelectedMonsters.doc(this.projectId).update({[currentMonster]: false});
          }
      }
      this.update();
    }
    //get mode
    observer.on('project:mode', (mode) => {
      console.log("what has been passed "+mode);
      this.mode = mode;
      console.log("in trigger "+this.mode);
      this.update();
    });
    selectMonster(){
      this.mode++;
      // trigger to pass mode
      observer.trigger('project:mode', this.mode);
      if(this.isNewProject){
        // Todo: save to database here (instead of in toggle)
        // project is now in progress
        observer.trigger('project:inprogress', this.projectId);
      }
      else{
        if(this.myMonsters){
          // save selected monster to database
          this.myMonsters.forEach((monster) => {
            if(monster.pick){
              var date = new Date();
              var timestring = date.getTime();
              //Paths must not contain '~', '*', '/', '[', or ']'
              refSelectedMonsters.doc(this.projectId).set({[monster.id]:  timestring});
            }
          });
        }
        // project was already in progress, now in monster help mode
        observer.trigger('project:monsterhelp', this.projectId);
      }
    }

</script>

<style>
  /* CSS */
  :scope {}
  .special {
    background-color: #333333;
    color: #FFFFFF;
  }
  /* Based of Birjitsinh code */
  .check {
    opacity: 0.5;
    color: #996;

  }
</style>
</pickmonster>
