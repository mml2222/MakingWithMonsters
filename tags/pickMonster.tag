<pickmonster>
  <!-- the image select check is based of Birjitsinh-->
  <!-- code found in https://bootsnipp.com/snippets/Zl6ql -->

  <!-- HTML -->
  <!-- Based of Birjitsinh code -->
  <div class="container">
    <h1 class="display-3 text-center">What monsters might help you on your journey?</h1>
    <div class="row">
      <form method="get">
        <div class="form-group">
          <div class="col-md-4" each={ monsterItem, i in myMonsters}>
            <label class="btn btn-info">
              <img src={ monsterItem.img } alt={ monsterItem.name } class="img-thumbnail img-check { check: monsterItem.pick }" onclick={ parent.toggle }>
              <input type="checkbox" name={ monsterItem.name } id={ monsterItem.id } class="hidden">
            </label>
          </div>
        </div>
      </div>
      <button type="button" class="btn btn-success" onclick={ selectMonster }>Next</button>
    </form>
  </div>
</div>

<script>
  // JAVASCRIPT
  var that = this;
  let database = firebase.firestore()
  var monsterRef = database.collection('Monsters');
  this.myMonsters = [];
  var monstersId = []; // add id with database
  //project id
  this.projectId = "test";

  //read monster assets from database
  monsterRef.onSnapshot(function (snapshot) {
    var monsters = [];
    snapshot.forEach(function (doc) {
      this.monster = true;
      monsters.push(doc.data());
    })
    that.myMonsters = monsters;
    that.update(); // We need to manually update
  });


  toggle(event) {
    // Based of Birjitsinh code change state of image css
    if (event.item.monsterItem.pick === false) {
      event.item.monsterItem.pick = true;
      //adds selected monsters to array
      monstersId.push(event.item.monsterItem.id);
      console.log(monstersId);
    } else {
      event.item.monsterItem.pick = false;
      var currentMonster = event.item.monsterItem.id;
      var deleteIndex = monstersId.indexOf(currentMonster);
      monstersId.splice(deleteIndex, 1);
      //write in array base pick false
      //call function selectMonster --> else (delete)
      // selectMonster(event);
    }
  }
  // receives projectId
  observer.on('project:created', (curProject) => {
    this.projectId = curProject;
    this.update();
  });

  selectMonster(event) {
    // write final pick array to database
    // get curProjectId when project is created
    //refences
		// let collectionRef = database.collection('UsersMonsters');
		// let userRef = collectionRef.doc(firebase.auth().currentUser.uid);
		// let userPreditedMonsters = userRef.collection('PredictedMonsters');
    // let projectRef = userPreditedMonsters.doc(this.projectId);

    let refPredictedMonsters = database.collection('UsersMonsters').doc(firebase.auth().currentUser.uid).collection('PredictedMonsters');//.doc(this.projectId);

    console.log(refPredictedMonsters);
    // console.log(this.projectRef); //doesn't work --> logs undefined


    // if(event.item.monsterItem.pick === true){
    //   collectionRef.doc(id).set({
    //
    //   });
    // } else {
    //
    // }
  }
  let stopListening;
  this.on('mount', () => {
    // DATABASE READ LIVE
    stopListening = monsterRef.onSnapshot(snapshot => {
      this.items = snapshot.docs.map(doc => doc.data());
      this.update();
    });
  });
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
