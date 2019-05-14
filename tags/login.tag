<login>
  <!-- HTML -->

  <button show={ !user } class="btn btn-outline-success my-2 my-sm-0 float-right" type="button" onclick={ login }>Login</button>
  <button show={ user } class="btn btn-outline-danger my-2 my-sm-0 float-right" type="button" onclick={ logout }>Logout</button>
  <br><br>
  <div show={!user}>
    <h1 class="display-3 text-center">Making with Monsters</h1>
    <img class="rounded mx-auto d-block" src="assets/images/monsters/allMonsters.png">
  </div>
  <br><br>
  <div show={ user }>
    <!-- if user signin shows them their homepage -->
    <h1 class="display-3 text-center">Making with Monsters</h1>
    <home></home>

  </div>
  <script>
    // JAVASCRIPT
    this.user;
    //set up database
    let database = firebase.firestore();
    this.firstProject = false;
    this.newProject = false;
    // reference to current user
    let refUser;
    login() {
			var provider = new firebase.auth.GoogleAuthProvider();
			firebase.auth().signInWithPopup(provider);
		}
		logout() {
			firebase.auth().signOut();
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
                database.doc('Users/' + firebase.auth().currentUser.uid).get()
                  .then(docSnapshot => {
                  if (!docSnapshot.exists) {
                     database.collection('Users').doc(firebase.auth().currentUser.uid).set(userInfo);
                   }
                 });
                 refUser = firebase.database().ref("Users/" + firebase.auth().currentUser.uid + '/Projects');
            });
            this.update();
          });
      }
      else {
        this.user = null;
        stopListening();
      }
      this.checkProject();
      this.update();
    });
    // check if have Projects
    checkProject(){
      this.projectCollection = database.collection('Users/').doc(firebase.auth().currentUser.uid).collection('Projects');
      this.projectCollection.get().then((querySnapshot) => {
        if (querySnapshot.empty === true) {
          this.firstProject = true;
          observer.trigger('project:firstProject', this.firstProject);
        }
        else {
          this.newProject = true;
          observer.trigger('project:newProject', this.newProject);
        }
      });
    }

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
