<pickMonster>
  <!-- the image select check is based of Birjitsinh-->
  <!-- code found in https://bootsnipp.com/snippets/Zl6ql -->

  <!-- HTML -->
  <!-- Based of Birjitsinh code -->
  <div class="container">
	<div class="row" >
		<form method="get">
		<div class="form-group">
      <div class="col-md-4" each={ monsterItem, i in myMonsters}>
          <label class="btn btn-info">
            <img src={ monsterItem.img } alt={ monsterItem.name } class="img-thumbnail img-check {check: pick }" onclick={ parent.toggle }>
            <input type="checkbox" name={ monsterItem.name } id={ monsterItem.id } class="hidden">
          </label>
        </div>
      </div>
		</div>
		<button type="button" class="btn btn-success">Next</button>
		</form>
	</div>
</div>



  <script>
    // JAVASCRIPT
    // this.monsterList = [
    //     { img: "assets/images/monsters/changeOneThingFull.png", name: 'monster1'},
    //     { img: "https://cdn.theatlantic.com/assets/media/img/mt/2017/10/Pict1_Ursinia_calendulifolia/lead_720_405.jpg?mod=1533691909", name: 'monster2'},
    //     { img: "https://cdn.theatlantic.com/assets/media/img/mt/2017/10/Pict1_Ursinia_calendulifolia/lead_720_405.jpg?mod=1533691909", name: 'monster3'},
    // ];
    var that = this;
    var monsterRef = firebase.firestore().collection('Monsters');
    this.myMonsters = [];

    //read monster assets from database
    monsterRef.onSnapshot(function(snapshot){
      var monsters = [];
      snapshot.forEach(function(doc) {
        this.monster = true;
        monsters.push(doc.data());
      })
      that.myMonsters = monsters;
      that.update(); // We need to manually update
    });

    toggle(event) {
      if (this.pick === false) {
				this.pick = true;
			} else {
				this.pick = false;
			}
			// let item = event.item.myMonsters;
			// item.pick = !item.pick;
			// selectMonster(item.id);
			// return true;
		}

    selectMonster(){
      // Based of Birjitsinh code
      // change state of image css
      this.pick = true;
      //write on database

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
    .check
    {
      opacity:0.5;
    	color:#996;

    }
  </style>
</pickMonster>
