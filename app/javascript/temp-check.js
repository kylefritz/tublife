const ewelink = require("ewelink-api");

const kyle = { email: "kyle.p.fritz@gmail.com" };

async function main() {
  console.log("calling ewelink api for temperature check");
  const { email } = kyle;
  const password = process.env.EWELINK_PASSWORD;
  if (!password) {
    throw "set env variable EWELINK_PASSWORD";
  }

  const connection = new ewelink({ email, password });

  /* get all devices */
  const devices = await connection.getDevices();
  // console.log(devices);
  devices.forEach((device) => {
    const { name, params } = device;
    const { currentTemperature: degreesCelsius, switch: switchState } = params;
    const degreesF = toFahrenheit(degreesCelsius);
    console.log(`${name} temp ${degreesF}°F pump: ${switchState}`);
  });
}

function toFahrenheit(degreesCelsius) {
  return (degreesCelsius * 9.0) / 5.0 + 32;
}

main();
