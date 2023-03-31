import type { NextApiRequest, NextApiResponse } from 'next'
import houses from "./db/house.json";
const fs = require('fs');

type IHouse = {
  name: string
  price: number
  minimumContribution: number
  isAvailable: boolean
  owner?: string
}

type IData = {
  message: string
  houses?: Array<IHouse>
}

export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<IData>
) {
  if (req.body && typeof req.body === 'string')
    req.body = JSON.parse(req.body);
  if (req.method === 'GET') {
    if (req.query?.address) return res.status(200).json({
      message: 'OK', houses: houses.houses.filter(function (item) {
        const address = req.query.address as string;
        return item.leaseHolder?.toLowerCase() == address.toLowerCase();
      })
    })
    else return res.status(200).json({ message: 'OK', houses: houses.houses })
  } else if(req.method === 'POST'){
    let newHouses = houses;
    const data = req.body;
    if (data.address) {
      newHouses.houses[data.id - 1].leaseHolder = data.address;
      newHouses.houses[data.id - 1].isAvailable = false;
      fs.writeFile("src/pages/api/db/house.json", JSON.stringify(newHouses), (e:any)=>console.log(e))
    } else {
      newHouses.houses[data.id - 1].isAvailable = true;
      fs.writeFile("src/pages/api/db/house.json", JSON.stringify(newHouses), (e:any)=>console.log(e))
    }
    return res.status(200).json({ message: 'OK' })
  } else {
    return res.status(400).json({ message: "METHOT_NOT_FOUND" });
  }
}
