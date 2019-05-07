<login>
  <!-- HTML -->
  <button show={ !user } class="btn btn-outline-success my-2 my-sm-0" type="button" onclick={ login }>Login</button>
  <button show={ user } class="btn btn-outline-danger my-2 my-sm-0" type="button" onclick={ logout }>Logout</button>
  <div show={ user }>
    <!-- if user signin shows them their homepage -->
    <home></home>
    <!-- first time using the app -->
    <div show={ !newProject }>
        <create></create>
    </div>
    <!-- mount new project when existing -->
    <div show={ !newProject }>
      <createExisting></createExisting>
    </div>

  </div>
  <script>
    // JAVASCRIPT
    this.user;
    //set up database
    let database = firebase.firestore();
    // reference to current user
    let refUser;
    login() {
			var provider = new firebase.auth.GoogleAuthProvider();
			firebase.auth().signInWithPopup(provider);
		}
		logout() {
			firebase.auth().signOut();
      let a;
      refUser.once("value").then(function(snapshot) {
        a = snapshot.exists();
      });
      console.log(a);
		}

    // Firebase authentication state listener
		firebase.auth().onAuthStateChanged(userObj => {
		  if (userObj) {
		    this.user = userObj;
				// start data listening
        stopListening = database.collection('Users').onSnapshot(snapshot => {
					snapshot.forEach(doc => {
            let userInfo = {
              id: firebase.auth().currentUser.uid,
              name: firebase.auth().currentUser.displayName,
              email: firebase.auth().currentUser.email
            };
             database.collection('Users').doc(firebase.auth().currentUser.uid).set(userInfo);
             refUser = firebase.database().ref("Users/" + firebase.auth().currentUser.uid + '/Projects');
          });
					this.update();
		    })
      }
      else {
		    this.user = null;
				stopListening();
		  }
			this.update();
		});

    //check if user has previous projects


  // console.log(a);


  </script>

  <style>
    /* CSS */
    :scope {}
    .special {
      background-color: #333333;
      color: #FFFFFF;
    }
  </style>
</login>
