import type { NextApiRequest, NextApiResponse } from 'next'
import houses from "./db/house.json";

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
    return res.status(200).json({ message: 'OK', houses: houses.houses })
  } else {
    return res.status(400).json({ message: "METHOT_NOT_FOUND" });
  }
}
