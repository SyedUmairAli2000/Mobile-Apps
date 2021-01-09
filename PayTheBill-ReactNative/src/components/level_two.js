import React, { useContext } from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { MyContext } from '../context'; 
import { Button } from 'react-native-elements';
const StageTwo = () => {
  const context = useContext(MyContext);
    return(
        <>
      <Text>This person will pay the bill</Text>
      <Text style={{fontSize:30,marginTop:20, fontStyle:'italic'}}>{context.state.result}</Text>
      <Button
          buttonStyle={styles.button}
          title="Try again"
          onPress={()=>context.getNewLooser()}
             />
      <Button
          buttonStyle={styles.button}
          title="Start over"
          onPress={()=>context.resetGame()}
             />       
    </>
    )
}

const styles = StyleSheet.create({
  button:{
    backgroundColor:'#1E90FF',
    marginTop:20
  }
})

export default StageTwo;