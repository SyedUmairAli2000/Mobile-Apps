import React,{Component} from 'react';
import Toast from 'react-native-toast-message';
const MyContext = React.createContext();

class MyProvider extends Component{
    state = {
        stage:1,
        players:[],
        result:''
    }

    addPlayerHandler = (name) => {
        this.setState((PrevState,props)=>({
           players:[
               ...PrevState.players,
               name
           ]
        }))
    }

    removePlayerHandler = (idx) => {
        let newArray = this.state.players;
        newArray.splice(idx,1);
        this.setState({players:newArray});
    }

    nextHandler = () => {
        const {players} = this.state;
        if(players.length < 2){
         Toast.show({
             type:'error',
             position:'Top',
             text1:'Error',
             text2:'You need atleast two players',
         });
        }
        else{
           this.setState({
               stage:2
           },()=>{
               this.generateLoser()
           })
        }
    }
  
    generateLoser = () => {
        const {players} = this.state;
        this.setState({
            result: players[Math.floor(Math.random()*players.length)]
        })
        }

        resetGame = () => {
            this.setState({
                stage:1,
                players:[],
                result:''
            })
        }
    
    render(){
         return(
             <>
             <MyContext.Provider value={{
                 state:this.state,
                 addPlayer:this.addPlayerHandler,
                 removePlayer:this.removePlayerHandler,
                 next:this.nextHandler,
                 getNewLooser:this.generateLoser,
                 resetGame:this.resetGame
             }}>
              {this.props.children}
            </MyContext.Provider>
             </>
         )
    }
}

export {
    MyProvider,
    MyContext
}