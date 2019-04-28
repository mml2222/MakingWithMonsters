<pickMonster>
  <!-- the image select check is based of Birjitsinh-->
  <!-- code found in https://bootsnipp.com/snippets/Zl6ql -->

  <!-- HTML -->
  <!-- Based of Birjitsinh code -->
  <div class="container">
	<div class="row" >
		<form method="get">
		<div class="form-group">
      <div each={ monsterItem, i in myMonsters }>
        <div class="col-md-3">
          <label class="btn btn-info">
            <img src={ monsterItem.img } alt= { monsterItem.name } class="img-thumbnail img-check">
            <input type="checkbox" name="m1" id="m1" value="true" class="hidden" autocomplete="off">
            <p>{ monsterItem.name }</p>
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
    //     { img: "https://cdn.theatlantic.com/assets/media/img/mt/2017/10/Pict1_Ursinia_calendulifolia/lead_720_405.jpg?mod=1533691909", name: 'monster1'},
    //     { img: "https://cdn.theatlantic.com/assets/media/img/mt/2017/10/Pict1_Ursinia_calendulifolia/lead_720_405.jpg?mod=1533691909", name: 'monster2'},
    //     { img: "https://cdn.theatlantic.com/assets/media/img/mt/2017/10/Pict1_Ursinia_calendulifolia/lead_720_405.jpg?mod=1533691909", name: 'monster3'},
    // ];
    var that = this;
    var monsterRef = firebase.firestore().collection('Monsters');
    this.myMonsters = [];

    //read monster assets from database
    monsterRef.onSnapshot(function(snapshot){
      var posts = [];

      console.log("monsters doc");

      snapshot.forEach(function(doc) {
        posts.push(doc.data());
      })
      that.myMonsters = posts;
      that.update(); // We need to manually update
      });


    // Based of Birjitsinh code
    // change state of image css
    $(document).ready(function(e){
    		$(".img-check").click(function(){
				$(this).toggleClass("check");
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
