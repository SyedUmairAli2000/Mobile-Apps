/* eslint-disable prettier/prettier */
import React from 'react';
import {View, Text, StyleSheet} from 'react-native';

const Header = ({title}) => {
  return (
    <View style={styles.Header}>
      <Text style={styles.Text}>{title}</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  Header: {
    height: 60,
    padding: 15,
    backgroundColor: 'darkslateblue',
  },
  Text: {
      color: '#fff',
      fontSize: 23,
      textAlign:'center',
  },
});

export default Header;
