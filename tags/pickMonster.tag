<pickmonster>
  <!-- the image select check is based of Birjitsinh-->
  <!-- code found in https://bootsnipp.com/snippets/Zl6ql -->
  <!-- HTML -->
  
  <!-- <div class="container">
    <h1 class="display-3 text-center">What monsters might help you on your journey?</h1>
    <div class="row">
      <form method="get">
        <div class="form-group">
          <div class="col-md-2" each={ monsterItem, i in myMonsters}>
            <label class="btn btn-info">
              <img src={ monsterItem.img } alt={ monsterItem.name } class="img-thumbnail img-check { check: monsterItem.pick }" onclick={ parent.toggle }>
              <input type="checkbox" name={ monsterItem.name } id={ monsterItem.id } class="hidden">
            </label>
          </div>
        </div>
      </div>
      <button type="button" class="btn btn-success" onclick={ selectMonster }>Next</button> <!-- need to add link to next page -->
  <!--  </form>
  </div>
</div> -->
<button class="btn btn-success" data-toggle="modal" data-target="#pickMonster">Pick Monster</button>
<div id="pickMonster" class="modal" data-backdrop="false" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h1> My Project: {inputProjectTitle} </h1>
      </div>
      <div class="modal-body">
        <h1 class="display-3 text-center">What monsters might help you on your journey?</h1>
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
        <button type="button" class="btn btn-success" onclick={ selectMonster }>Next</button>
        <button class="btn btn-danger" data-dismiss="modal">Cancel</button>
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
  let refPredictedMonsters;

  //read monster assets from database
  monsterRef.onSnapshot(function (snapshot) {
    var monsters = [];
    snapshot.forEach(function (doc) {
      monsters.push(doc.data());
    })
    that.myMonsters = monsters;
    that.update();
  });

  // receives projectId
  observer.on('project:created', (curProject) => {
    this.projectId = curProject;
    this.update();
    //adds to database the possible monsters
    refPredictedMonsters = database.doc('UserMonsters/' + firebase.auth().currentUser.uid).collection('PredictedMonsters');
    refPredictedMonsters.doc(this.projectId).set({//try to make it reading from the database
      askExpert: false,
      changeOneThing: false,
      compareIt: false,
      lookItUp: false,
      playWith:false,
      takeBreak:false,
      talkFriend:false
    });
  });
  // receives projectId
  observer.on('project:name', (curName) => {
    this.inputProjectTitle = curName;
    this.update();
  });

  toggle(event) {
    refPredictedMonsters = database.doc('UserMonsters/' + firebase.auth().currentUser.uid).collection('PredictedMonsters');
    let currentMonster = event.item.monsterItem.id;
    console.log(currentMonster);
    if (event.item.monsterItem.pick === false) {
      event.item.monsterItem.pick = true;
      //update database
      refPredictedMonsters.doc(this.projectId).update({[currentMonster]: true});
    }
    else {
        event.item.monsterItem.pick = false;
        //update database
        refPredictedMonsters.doc(this.projectId).update({[currentMonster]: false});
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
