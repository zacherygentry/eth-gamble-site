import web3 from './web3';
import Casino from '../abis/Casino.json';

const getCasinoContract = (networkId) => {
  // Can get networkId from frontend using `const networkId = await web3.eth.net.getId();`
  return new web3.eth.Contract(Casino.abi, Casino.networks[networkId].address);
};

export default getCasinoContract;
